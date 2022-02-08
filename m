Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2135D4AE512
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Feb 2022 23:55:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232979AbiBHWzA (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 8 Feb 2022 17:55:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233331AbiBHWy7 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 8 Feb 2022 17:54:59 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CCB9AC06157A;
        Tue,  8 Feb 2022 14:54:58 -0800 (PST)
Received: from [192.168.1.17] (unknown [192.182.151.181])
        by linux.microsoft.com (Postfix) with ESMTPSA id 56ABC20B90DE;
        Tue,  8 Feb 2022 14:54:58 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 56ABC20B90DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1644360898;
        bh=PXDFHmo+Dn60GWarEPhOD+A65Emq1lrbDy0sHhKFVXI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=qpedj7YILdoUCnUlRWICdS3/lYz+s1X3wnab+qIx5QXDN8EZqA40xWZ5s4hLIwANT
         ZI9ZWYjL8hNCkpcPHdK8IoAIuuAsay7rdIimQ/RdC6XRR4yvXu0TYqU/A6W14FNzI1
         nJEtNEeyB2tc+iunwH4GFgFEb5YgMPGNKa+ClJIU=
Message-ID: <a4a00a29-89f8-5f42-0a7f-668e6b68f5d4@linux.microsoft.com>
Date:   Tue, 8 Feb 2022 14:54:57 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v2 19/24] drivers: hv: dxgkrnl: Simple IOCTLs LX_DXESCAPE,
 LX_DXMARKDEVICEASERROR, LX_DXQUERYSTATISTICS, LX_DXQUERYCLOCKCALIBRATION
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, spronovo@microsoft.com
References: <cover.1644025661.git.iourit@linux.microsoft.com>
 <07c352a82707304cc5836313b97dfd97be8c7354.1644025661.git.iourit@linux.microsoft.com>
 <Yf41lZtUntrb8V7Z@kroah.com>
From:   Iouri Tarassov <iourit@linux.microsoft.com>
In-Reply-To: <Yf41lZtUntrb8V7Z@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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


On 2/5/2022 12:30 AM, Greg KH wrote:
> On Fri, Feb 04, 2022 at 06:34:17PM -0800, Iouri Tarassov wrote:
>
> >       on the host.
> > 
> >     - LX_DXQUERYCLOCKCALIBRATION
> >       The IOCTL queries clock from the compute device.
>
> Why is this not broken up into one-patch-per-ioctl like I asked?
>
Hi Greg,

There is an article, which asks not to submit too many patches at once:
Submitting patches: the essential guide to getting your code into the 
kernel — The Linux Kernel documentation 
<https://www.kernel.org/doc/html/latest/process/submitting-patches.html><https://www.kernel.org/doc/html/latest/process/submitting-patches.html>

NO!!!! No more huge patch bombs 
to<https://www.kernel.org/doc/html/latest/process/submitting-patches.html>linux-kernel@vger.kernel.org 
<mailto:linux-kernel%40vger.kernel.org>people!
<https://www.kernel.org/doc/html/latest/process/submitting-patches.html>
    <https://www.kernel.org/doc/html/latest/process/submitting-patches.html>

    <
    <https://www.kernel.org/doc/html/latest/process/submitting-patches.html>https://lore.kernel.org/r/20050711.125305.08322243.davem@davemloft.net
    <https://lore.kernel.org/r/20050711.125305.08322243.davem@davemloft.net>>

This is confusing as you are requesting more patches. What options do I 
have?
- should I remove linux-kernel@vger.kernel.org until you are happy with 
the review?
- can I submit a small number of patches for a non fully functional 
driver and submit the next portion after they are reviewed and accepted?

Thanks
Iouri

