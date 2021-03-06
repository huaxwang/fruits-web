package com.king.fruits.core.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;

/**
 * 版权：融贯资讯 <br/>
 * 作者：xuan.zhou@rogrand.com <br/>
 * 生成日期：2014-1-21 <br/>
 * 描述：〈FFmpeg转换工具〉
 */
public class FFmpegUtils {

    protected static Logger logger = Logger.getLogger(FFmpegUtils.class);

    public static String FFMPEG = "ffmpeg";

    /**
     * 描述：〈Wav转换Mp3〉 <br/>
     * 作者：xuan.zhou@rogrand.com <br/>
     * 生成日期：2014-1-28 <br/>
     * 
     * @param srcPath wav文件路径
     * @param destPath mp3文件路径
     * @return 是否成功
     */
    public static boolean convertWavToMp3(String srcPath, String destPath) {
        List<String> command = new ArrayList<String>();

        command.add(FFMPEG);
        command.add("-i");
        command.add(srcPath);
        command.add("-vn");
        command.add("-ar");
        command.add("44100");
        command.add("-ac");
        command.add("2");
        command.add("-ab");
        command.add("192");
        command.add("-f");
        command.add("mp3");
        command.add(destPath);

        StringBuilder cmd = new StringBuilder();
        for (String arg : command) {
            cmd.append(arg).append(" ");
        }

        logger.info("执行转换命令:" + cmd.toString());

        try {
            ProcessBuilder builder = new ProcessBuilder();
            builder.command(command);
            
            Process process = builder.start();
            
            logger.debug("\r\n" + readInputFromProcess(process));
            
            int exitVal = process.waitFor();
            
            logger.info("转换完毕[" + exitVal + "]!");

            return true;
        } catch (Exception e) {
            logger.error("转换过程中发生错误:" + e.getMessage(), e);

            return false;
        }
    }

    /**
     * 描述：〈获取输出内容〉 <br/>
     * 作者：xuan.zhou@rogrand.com <br/>
     * 生成日期：2014-1-28 <br/>
     * 
     * @param process 执行进程对象
     * @return 进程输出内容
     */
    private static String readInputFromProcess(Process process) {
        StringBuffer buf = new StringBuffer();

        InputStream is = null;
        InputStreamReader isr = null;
        BufferedReader br = null;
        try {
            is = process.getErrorStream();
            isr = new InputStreamReader(is);
            br = new BufferedReader(isr);

            String line = "";
            while ((line = br.readLine()) != null) {
                buf.append(line).append("\r\n");
            }
        } catch (IOException e) {
            logger.error("获取本地进程输出内容失败:" + e.getMessage(), e);
        } finally {
            if (br != null) {
                try {
                    br.close();
                } catch (IOException e) {
                    br = null;
                }
            }

            if (isr != null) {
                try {
                    isr.close();
                } catch (IOException e) {
                    isr = null;
                }
            }

            if (is != null) {
                try {
                    is.close();
                } catch (IOException e) {
                    is = null;
                }
            }
        }

        return buf.toString();
    }
}
