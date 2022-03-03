Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 150314CB4B4
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Mar 2022 03:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbiCCCCQ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Mar 2022 21:02:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbiCCCCP (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Mar 2022 21:02:15 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 61070D4F;
        Wed,  2 Mar 2022 18:01:31 -0800 (PST)
Received: from [192.168.1.17] (unknown [192.182.151.181])
        by linux.microsoft.com (Postfix) with ESMTPSA id ED49A20B7178;
        Wed,  2 Mar 2022 18:01:30 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com ED49A20B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1646272891;
        bh=HRZWLfNLDmejiTzerK5LeZIGiDIHUtm5/ESNLuqANEM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=oZXOSRjP4itPe4fMkFXrDW6V1SPbBXePMXlLhljEFwarHfzUCuRLKoXKoxBnOvq/l
         0PrbX6o+yRCMts8oLOzhoO+oNVXCQWgxFqokBXFE2bL7WVHMAmkr5v9UWD/hTGQ7xs
         qScEaJ1z0RiKBp7isGUL86fpUPuGVYk8mvsjN6tg=
Message-ID: <6371e5d5-1d18-49df-1c4c-9d8cb49be3e3@linux.microsoft.com>
Date:   Wed, 2 Mar 2022 18:01:30 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v3 02/30] drivers: hv: dxgkrnl: Driver initialization and
 loading
Content-Language: en-US
To:     Wei Liu <wei.liu@kernel.org>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        spronovo@microsoft.com, spronovo@linux.microsoft.com,
        gregkh@linuxfoundation.org
References: <719fe06b7cbe9ac12fa4a729e810e3383ab421c1.1646163378.git.iourit@linux.microsoft.com>
 <739cf89e71ff72436d7ca3f846881dfb45d07a6a.1646163378.git.iourit@linux.microsoft.com>
 <20220301220636.mqrzq7h3epfw3u3x@liuwe-devbox-debian-v2>
From:   Iouri Tarassov <iourit@linux.microsoft.com>
In-Reply-To: <20220301220636.mqrzq7h3epfw3u3x@liuwe-devbox-debian-v2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org


On 3/1/2022 2:06 PM, Wei Liu wrote:
> I will skip things that are pointed out by Greg.
>
> On Tue, Mar 01, 2022 at 11:45:49AM -0800, Iouri Tarassov wrote:
> > - Create skeleton and add basic functionality for the
> > hyper-v compute device driver (dxgkrnl).
> > 
> > - Register for PCI and VM bus driver notifications and
> > handle initialization of VM bus channels.
> > 
> > - Connect the dxgkrnl module to the drivers/hv/ Makefile and Kconfig
> > 
> > - Create a MAINTAINERS entry
> > 
> > A VM bus channel is a communication interface between the hyper-v guest
> > and the host. The are two type of VM bus channels, used in the driver:
> >   - the global channel
> >   - per virtual compute device channel
> > 
>
> Same comment regarding the spelling of VMBus and Hyper-V. Please fix
> other instances in code and comments.
>
> > A PCI device is created for each virtual compute device, projected
> > by the host. The device vendor is PCI_VENDOR_ID_MICROSOFT and device
> > id is PCI_DEVICE_ID_VIRTUAL_RENDER. dxg_pci_probe_device handles
> > arrival of such devices. The PCI config space of the virtual compute
> > device has luid of the corresponding virtual compute device VM
> > bus channel. This is how the compute device adapter objects are
> > linked to VM bus channels.
> > 
> > VM bus interface version is exchanged by reading/writing the PCI config
> > space of the virtual compute device.
> > 
> > The IO space is used to handle CPU accessible compute device
> > allocations. Hyper-v allocates IO space for the global VM bus channel.
> > 
> > Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
> > ---
> [...]
> > +static inline void guid_to_luid(guid_t *guid, struct winluid *luid)
> > +{
> > +	*luid = *(struct winluid *)&guid->b[0];
> > +}
>
> This should be moved to the header where luid is defined -- presumably
> this is useful for other things in the future too.
>
> Also, please provide a comment on why this conversion is okay.
>
The definition of the structure is in the public header. I do not think it makes sense to move the function there. It is a detail of the internal implementation. There is no official conversion of GUID to LUID.

The comment will be added.

Thanks
Iouri


