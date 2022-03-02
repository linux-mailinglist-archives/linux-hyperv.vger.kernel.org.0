Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81A8E4CAD49
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Mar 2022 19:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244677AbiCBSPr (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Mar 2022 13:15:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244540AbiCBSPn (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Mar 2022 13:15:43 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 33F701EC65;
        Wed,  2 Mar 2022 10:14:21 -0800 (PST)
Received: from [192.168.1.17] (unknown [192.182.151.181])
        by linux.microsoft.com (Postfix) with ESMTPSA id DBD1920B7188;
        Wed,  2 Mar 2022 10:13:34 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DBD1920B7188
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1646244815;
        bh=W0k6fnWr5oI0rAQaMmKdArqS57ZUM8/CkCSD+7Svluo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=EAds+gLJ59BMV3kBez18kp1WdcHxqdhuTQKattNMuUsh8CcEIrGhcV/7hIp0SsZy2
         dza9qGxBp/hY+Z4a63mKT6Lg0YDY9MHVS3TZTsGQrS2S0Zj+UtRnOPBE+xnCk1vRJl
         pftZWmCw9AwDZaVYB5EvWeG3BNabipBpLl3+MtS0=
Message-ID: <fe018236-35b5-3bc1-6984-fca9537e47c7@linux.microsoft.com>
Date:   Wed, 2 Mar 2022 10:13:34 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v3 26/30] drivers: hv: dxgkrnl: Offer and reclaim
 allocations
Content-Language: en-US
To:     Wei Liu <wei.liu@kernel.org>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        spronovo@microsoft.com, spronovo@linux.microsoft.com,
        gregkh@linuxfoundation.org
References: <719fe06b7cbe9ac12fa4a729e810e3383ab421c1.1646163378.git.iourit@linux.microsoft.com>
 <3a6779567438b02566012679f01ebb065e3761db.1646163379.git.iourit@linux.microsoft.com>
 <20220302142517.kgc5o7ufj2yf4cif@liuwe-devbox-debian-v2>
From:   Iouri Tarassov <iourit@linux.microsoft.com>
In-Reply-To: <20220302142517.kgc5o7ufj2yf4cif@liuwe-devbox-debian-v2>
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


On 3/2/2022 6:25 AM, Wei Liu wrote:
> On Tue, Mar 01, 2022 at 11:46:13AM -0800, Iouri Tarassov wrote:
> > Implement ioctls to offer and reclaim compute device allocations:
> >   - LX_DXOFFERALLOCATIONS,
> >   - LX_DXRECLAIMALLOCATIONS2
> > 
> > When a user mode driver (UMD) does not need to access an allocation,
>
> What is a "user mode driver" in this context? Is that something that
> runs inside the guest?

Hi Wei,

The user mode driver runs inside the guest. This driver is written by
hardware vendors.
For example, the NVIDIA's Cuda runtime is considered a user mode driver.
The driver
provides a specific API to applications (like the Cuda API).

The cover letter explains the design of the virtual compute device
paravirtualization
model and describes all components, which are involved. I feel that I do
not need to
include explanation to every patch.

Thanks
Iouri

