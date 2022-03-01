Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68EB44C997A
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Mar 2022 00:47:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238705AbiCAXsb (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 1 Mar 2022 18:48:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235135AbiCAXsa (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 1 Mar 2022 18:48:30 -0500
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC453669E;
        Tue,  1 Mar 2022 15:47:47 -0800 (PST)
Received: by mail-wm1-f49.google.com with SMTP id i66so102204wma.5;
        Tue, 01 Mar 2022 15:47:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qmLB0MmP9uqP6RXGIR5raG+mUMpoENIoAsqy7EycV20=;
        b=ZipqvlJcROUMsZmurkm/of87fVRKk9ggzN9iBn+Y48P6VlcLTCuGrLXLgJOZE0iNSI
         9UxcTysSENXy1p0C6pMzrUjFMKwiwAkavHAxiPFUHqVqbQsjWRisAPicMNNuKAk15OoS
         Gy+GoXOz34eBrX6HwahE7m2zjR8i87y0cNUVhuwieAKXI/w+4WOEBpMoGDMGuc2n8c67
         oGzxP63GumYKGBRl4fei4jvg1v0s13tShnsacNKeIRLud4Fsa6DQnIuL0BAm2sEHrdYd
         C0DhHV1LTgysdgpbkJ0BKnZ2Qjj7YHzrmSbeYqTuIdMR/QuV5NDVXj4gD43x4Z62FytT
         xKlg==
X-Gm-Message-State: AOAM532CcJFsJAq1JQultHDRVBqrwyzB0a+vEZC86j3KMF8BxBMN4ac0
        RKVpBxSf8vOMi2fLrFMm6LY=
X-Google-Smtp-Source: ABdhPJyalSpZbyzReMK/ZICuWkJdF6/03nilqKrIX1kJ/PdO2vlSnQvser06uhFbphiD73VLZih6Dg==
X-Received: by 2002:a1c:1905:0:b0:34f:477e:8850 with SMTP id 5-20020a1c1905000000b0034f477e8850mr18719625wmz.131.1646178466554;
        Tue, 01 Mar 2022 15:47:46 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id f9-20020adffcc9000000b001e9e8163a46sm21199976wrs.54.2022.03.01.15.47.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 15:47:46 -0800 (PST)
Date:   Tue, 1 Mar 2022 23:47:44 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Iouri Tarassov <iourit@linux.microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, spronovo@microsoft.com,
        spronovo@linux.microsoft.com, gregkh@linuxfoundation.org
Subject: Re: [PATCH v3 05/30] drivers: hv: dxgkrnl: Opening of /dev/dxg
 device and dxgprocess creation
Message-ID: <20220301234744.plggauzg4ka5p3tm@liuwe-devbox-debian-v2>
References: <719fe06b7cbe9ac12fa4a729e810e3383ab421c1.1646163378.git.iourit@linux.microsoft.com>
 <419b863b2848b9e86382511a2f0f12cf91065578.1646163378.git.iourit@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <419b863b2848b9e86382511a2f0f12cf91065578.1646163378.git.iourit@linux.microsoft.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Mar 01, 2022 at 11:45:52AM -0800, Iouri Tarassov wrote:
> - Implement opening of the device (/dev/dxg) file object and creation of
> dxgprocess objects.
[...]
>  static int dxgk_open(struct inode *n, struct file *f)
>  {
> -	return 0;
> +	int ret = 0;
> +	struct dxgprocess *process;
> +
> +	pr_debug("%s %p %d %d",
> +		     __func__, f, current->pid, current->tgid);
> +
> +
> +	/* Find/create a dxgprocess structure for this process */
> +	process = dxgglobal_get_current_process();
> +
> +	if (process) {
> +		f->private_data = process;
> +	} else {
> +		pr_debug("cannot create dxgprocess for open\n");
> +		ret = -EBADF;
> +	}
> +
> +	pr_debug("%s end %x", __func__, ret);

I would normally remove pr_deubg's like this when submitting. It doesn't
provide much information.

> +	return ret;
>  }
>  
[...]
>  
> +int dxgvmb_send_create_process(struct dxgprocess *process)
> +{
> +	int ret;
> +	struct dxgkvmb_command_createprocess *command;
> +	struct dxgkvmb_command_createprocess_return result = { 0 };
> +	struct dxgvmbusmsg msg;
> +	char s[WIN_MAX_PATH];
> +	int i;
> +
> +	ret = init_message(&msg, NULL, process, sizeof(*command));
> +	if (ret)
> +		return ret;
> +	command = (void *)msg.msg;
> +
> +	ret = dxgglobal_acquire_channel_lock();
> +	if (ret < 0)
> +		goto cleanup;
> +
> +	command_vm_to_host_init1(&command->hdr, DXGK_VMBCOMMAND_CREATEPROCESS);
> +	command->process = process;
> +	command->process_id = process->process->pid;
> +	command->linux_process = 1;
> +	s[0] = 0;
> +	__get_task_comm(s, WIN_MAX_PATH, process->process);
> +	for (i = 0; i < WIN_MAX_PATH; i++) {
> +		command->process_name[i] = s[i];
> +		if (s[i] == 0)
> +			break;
> +	}

What's wrong with doing

  __get_task_comm(command->process_name, WIN_MAX_PATH, process->process);

here?

That saves you many bytes on stack.

[...]
> +static char *errorstr(int ret)
> +{
> +	return ret < 0 ? "err" : "";
> +}
> +

This is not used in this patch.

[...]
> diff --git a/drivers/hv/dxgkrnl/misc.h b/drivers/hv/dxgkrnl/misc.h
> index 1ff0c0e28332..433b59d3eb23 100644
> --- a/drivers/hv/dxgkrnl/misc.h
> +++ b/drivers/hv/dxgkrnl/misc.h
> @@ -31,7 +31,6 @@ extern const struct d3dkmthandle zerohandle;
>   * table_lock
>   * core_lock
>   * device_lock
> - * process->process_mutex

Why is this deleted?

Thanks,
Wei.
