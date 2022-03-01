Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F6D4C9825
	for <lists+linux-hyperv@lfdr.de>; Tue,  1 Mar 2022 23:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235104AbiCAWHX (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 1 Mar 2022 17:07:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbiCAWHW (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 1 Mar 2022 17:07:22 -0500
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C4E79A9BF;
        Tue,  1 Mar 2022 14:06:40 -0800 (PST)
Received: by mail-wr1-f42.google.com with SMTP id d17so22676123wrc.9;
        Tue, 01 Mar 2022 14:06:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jXNWi4tflLbdxNUaNsAzZdjuXaOCikdIRH8LBw/41FM=;
        b=ZN1/nD6SaemAuuSyjYLV4n7T0V2CmpHvXuP23pI5KlVddOu3kw8hoABqrBprGK5s4C
         pmn1UgZ3LP5d2ekJg1ARA8AiqCuqlrf+7sN/DDixJXh4TymYviCZFcepFg8WIhzusD/X
         PPFO61p/PIIMzRVwqrJ7U8Fe9W61bnmi3dfKd19j/rFjssztrf24wbjt6Hu+tyaMWSsB
         kj3kMxIMEhzSL6OwnJacQdlLUwLyagi/W1TJLOD353RNUv6DUuCXKYYF+RaX9fFeitW9
         s2M1H6id2zgzPRI7MlrhZzBR7uaUEZbrFNdK6wQnCIsWUVytAvgLS7O4NvKqKWPIVVBm
         5Aig==
X-Gm-Message-State: AOAM531YOKNGsJfRF5sxpqhVEaWdQIfsZANhegUM3t/+TVHsxYjWBDuZ
        430rslXZgeO3J+NS6KmNexU1Gxqbpu0=
X-Google-Smtp-Source: ABdhPJz77X85NKTeXnjSDVPgBEAo/gaz5LKN3+xx20pw4s6abbAA98GF6zyhudRgWzXUJIL6DBRrLA==
X-Received: by 2002:a5d:5746:0:b0:1ea:9643:92ac with SMTP id q6-20020a5d5746000000b001ea964392acmr20549749wrw.597.1646172398668;
        Tue, 01 Mar 2022 14:06:38 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id n4-20020a05600c4f8400b00380e45cd564sm4421834wmq.8.2022.03.01.14.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 14:06:38 -0800 (PST)
Date:   Tue, 1 Mar 2022 22:06:36 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Iouri Tarassov <iourit@linux.microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, spronovo@microsoft.com,
        spronovo@linux.microsoft.com, gregkh@linuxfoundation.org
Subject: Re: [PATCH v3 02/30] drivers: hv: dxgkrnl: Driver initialization and
 loading
Message-ID: <20220301220636.mqrzq7h3epfw3u3x@liuwe-devbox-debian-v2>
References: <719fe06b7cbe9ac12fa4a729e810e3383ab421c1.1646163378.git.iourit@linux.microsoft.com>
 <739cf89e71ff72436d7ca3f846881dfb45d07a6a.1646163378.git.iourit@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <739cf89e71ff72436d7ca3f846881dfb45d07a6a.1646163378.git.iourit@linux.microsoft.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

I will skip things that are pointed out by Greg.

On Tue, Mar 01, 2022 at 11:45:49AM -0800, Iouri Tarassov wrote:
> - Create skeleton and add basic functionality for the
> hyper-v compute device driver (dxgkrnl).
> 
> - Register for PCI and VM bus driver notifications and
> handle initialization of VM bus channels.
> 
> - Connect the dxgkrnl module to the drivers/hv/ Makefile and Kconfig
> 
> - Create a MAINTAINERS entry
> 
> A VM bus channel is a communication interface between the hyper-v guest
> and the host. The are two type of VM bus channels, used in the driver:
>   - the global channel
>   - per virtual compute device channel
> 

Same comment regarding the spelling of VMBus and Hyper-V. Please fix
other instances in code and comments.

> A PCI device is created for each virtual compute device, projected
> by the host. The device vendor is PCI_VENDOR_ID_MICROSOFT and device
> id is PCI_DEVICE_ID_VIRTUAL_RENDER. dxg_pci_probe_device handles
> arrival of such devices. The PCI config space of the virtual compute
> device has luid of the corresponding virtual compute device VM
> bus channel. This is how the compute device adapter objects are
> linked to VM bus channels.
> 
> VM bus interface version is exchanged by reading/writing the PCI config
> space of the virtual compute device.
> 
> The IO space is used to handle CPU accessible compute device
> allocations. Hyper-v allocates IO space for the global VM bus channel.
> 
> Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
> ---
[...]
> +static inline void guid_to_luid(guid_t *guid, struct winluid *luid)
> +{
> +	*luid = *(struct winluid *)&guid->b[0];
> +}

This should be moved to the header where luid is defined -- presumably
this is useful for other things in the future too.

Also, please provide a comment on why this conversion is okay.

[...]
> + * A helper function to read PCI config space.
> + */
> +static int dxg_pci_read_dwords(struct pci_dev *dev, int offset, int size,
> +			       void *val)
> +{
> +	int off = offset;
> +	int ret;
> +	int i;
> +

I think you should check for alignment here? size has to be a round
number of sizeof(int) otherwise you risk reading cross boundary and
causes unintended side effect?

> +	for (i = 0; i < size / sizeof(int); i++) {
> +		ret = pci_read_config_dword(dev, off, &((int *)val)[i]);
> +		if (ret) {
> +			pr_err("Failed to read PCI config: %d", off);
> +			return ret;
> +		}
> +		off += sizeof(int);
> +	}
> +	return 0;
> +}
> +
> +static int dxg_pci_probe_device(struct pci_dev *dev,
> +				const struct pci_device_id *id)
> +{
> +	int ret;
> +	guid_t guid;
> +	u32 vmbus_interface_ver = DXGK_VMBUS_INTERFACE_VERSION;
> +	struct winluid vgpu_luid = {};
> +	struct dxgk_vmbus_guestcaps guest_caps = {.wsl2 = 1};
> +
> +	mutex_lock(&dxgglobal->device_mutex);
> +
> +	if (dxgglobal->vmbus_ver == 0)  {
> +		/* Report capabilities to the host */
> +
> +		ret = pci_write_config_dword(dev, DXGK_VMBUS_GUESTCAPS_OFFSET,
> +					guest_caps.guest_caps);
> +		if (ret)
> +			goto cleanup;
> +
> +		/* Negotiate the VM bus version */
> +
[...]
> +	pr_debug("Adapter channel: %pUb\n", &guid);
> +	pr_debug("Vmbus interface version: %d\n",
> +		dxgglobal->vmbus_ver);

No need to wrap the line here.

> +	pr_debug("Host vGPU luid: %x-%x\n",
> +		vgpu_luid.b, vgpu_luid.a);

Ditto.

> +
> +cleanup:
> +
> +	mutex_unlock(&dxgglobal->device_mutex);
> +
> +	if (ret)
> +		pr_debug("err: %s %d", __func__, ret);
> +	return ret;
> +}
> +
[...]
> +static void __exit dxg_drv_exit(void)
> +{
> +	dxgglobal_destroy();
> +}
> +
> +module_init(dxg_drv_init);
> +module_exit(dxg_drv_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Microsoft Dxgkrnl virtual GPU Driver");

Should be "virtual compute device driver" here? Please be consistent.

Thanks,
Wei.
