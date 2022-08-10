Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C50C58EB1E
	for <lists+linux-hyperv@lfdr.de>; Wed, 10 Aug 2022 13:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231991AbiHJLTW (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 10 Aug 2022 07:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbiHJLTW (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 10 Aug 2022 07:19:22 -0400
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0999B73306
        for <linux-hyperv@vger.kernel.org>; Wed, 10 Aug 2022 04:19:21 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id a11so7631239wmq.3
        for <linux-hyperv@vger.kernel.org>; Wed, 10 Aug 2022 04:19:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=l1G6OVM+CO9FcP43w99k/7coezmapD7pMTBECFs71Aw=;
        b=Ma/gTEu4PTqmF9SsJOvvYsE5sSitH4traN900v7r0JGuJIKlFAZrB3Uhpvt6YDX4id
         FmxFDGt175fZL15O+aEe+ldKjVvw/KcLr6My9qRNOtqCS6rJTS4iiLkkPhzFQhOYjUrc
         sufayT27Wnig6G+sWBVsgtyGMVnaKbXU7dZ8xzS2gdEQzH4VrY8lKjpJ4dIDk58B8leo
         aVmRBJkYpHbX8XkSGUsydP18RIhEGklSB/O4bGVPHTEb5CulPhm9ljKTubTSKZQAuK9j
         vav3NKkgCotRapygw4x7BuF/qtsMW9f8YMY3YSo5pWkLEnFQyCJmEjKXFAd3qEqVm7Lf
         OoYg==
X-Gm-Message-State: ACgBeo1ofTgHdPE5guJUIq+0cpfHcZBMUlrcPfQeQg0h7kz65dOX88JQ
        6DSUh4yrFtc2k8HvcUtNYfQ=
X-Google-Smtp-Source: AA6agR44UTV79QIwUwazuOEJCAaHxJSnrH43NW5Br3m3P8uzQtrGTJQUP3KOwzOZe7GnNEwEYH+6mQ==
X-Received: by 2002:a1c:218b:0:b0:3a5:b5d4:9741 with SMTP id h133-20020a1c218b000000b003a5b5d49741mr1284651wmh.28.1660130359473;
        Wed, 10 Aug 2022 04:19:19 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id t28-20020adfa2dc000000b0021f17542fe2sm16155128wra.84.2022.08.10.04.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 04:19:19 -0700 (PDT)
Date:   Wed, 10 Aug 2022 11:19:17 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Anish Gupta <anish@exotanium.io>
Cc:     linux-hyperv@vger.kernel.org, Wei Liu <wei.liu@kernel.org>
Subject: Re: Booting Xen dom0 on Hyper-V
Message-ID: <20220810111917.f4wunm24engy2sia@liuwe-devbox-debian-v2>
References: <43091FDA-F0E9-42CE-8B15-A57F3B0C5B4A@exotanium.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43091FDA-F0E9-42CE-8B15-A57F3B0C5B4A@exotanium.io>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Anish

On Tue, Aug 09, 2022 at 10:10:03PM +0530, Anish Gupta wrote:
> Hello all,
> I am new to Azure/Hyper-V environment and trying to boot Xen PV.  Dom0 Linux on Xen doesn’t detect hv_vmbus and boot fails. I get the same result even with Xen HYPERV_GUEST config. Here is the console logs with latest Xen 4.15.3 and Linux 5.18:
> 
[...]
> [    0.000000] SMBIOS 2.3 present.
> [    0.000000] DMI: Microsoft Corporation Virtual Machine/Virtual Machine, BIOS 090008  12/07/2018
> [    0.000000] Hypervisor detected: Xen PV <<<
> …

This is expected.

> [  197.060965] dracut-initqueue[311]: Warning: Could not boot.
> [  197.067020] dracut-initqueue[311]: Warning: /dev/disk/by-uuid/c8396182-9335-4bf7-a963-f14e85f41f23 does not exist
>          Starting Setup Virtual Console...
> [  OK  ] Started Setup Virtual Console.
>          Starting Dracut Emergency Shell...
> Warning: /dev/disk/by-uuid/c8396182-9335-4bf7-a963-f14e85f41f23 does not exist
> 
> Generating "/run/initramfs/rdsosreport.txt"
> 
> 
> Entering emergency mode. Exit the shell to continue.
> Type "journalctl" to view system logs.
> You might want to save "/run/initramfs/rdsosreport.txt" to a USB stick or /boot
> after mounting them and attach it to a bug report.
> 
> 
> dracut:/# 
> 
> 
> As an experiment I did force load hv_vmbus but then hit a page fault. I will really appreciate guidance in getting it working. 
> 

What did the backtrace show?

> Was Xen PV ever supported in any version of Xen + Linux on Azure/Hyper-V?

I never got the time to make it work with VMBus based devices.

The initial development work was done on a Gen1 VM locally with emulated
hard drive and network adapter. Azure Gen2 VMs don't have emulated
devices.

In hv_acpi_init, you can see that if the hypervisor personality is not
Hyper-V then that function returns -ENODEV.

I think you will need to find a way to initialize VMBus somehow.

Fundamentally, you're trying to achieve mixed-personalities in a single
system. I think it is going to require non-trivial investment to make it
work properly.

Thanks,
Wei.
