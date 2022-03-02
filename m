Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A93FC4CB315
	for <lists+linux-hyperv@lfdr.de>; Thu,  3 Mar 2022 00:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbiCBXxD (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Mar 2022 18:53:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiCBXwr (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Mar 2022 18:52:47 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 54B4B1A802;
        Wed,  2 Mar 2022 15:52:02 -0800 (PST)
Received: from [192.168.1.17] (unknown [192.182.151.181])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8952E20B7178;
        Wed,  2 Mar 2022 15:27:56 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8952E20B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1646263676;
        bh=5KvOsKwug+N0UsgvLNjMfAoBITxIY5JfWuFek8c6W6I=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=N9dJI5zEX5kl97tkKa4n/yyeKwGJSfbPRAjJRdRj2cYT0nvf7a5CWWu5WO2ahrD3X
         BBrg5BYPR2rNIwfmni5dyoOL5gK3KVGc6I5IbM/zQkn1Zbiua4k2zM+uj+NVZSu/qW
         oN8LIYkoxJZyUJdS3hD0OYDnm1Spjh/PsMGUCfJY=
Message-ID: <6b691648-96ce-f28e-436e-f5eb4137e73b@linux.microsoft.com>
Date:   Wed, 2 Mar 2022 15:27:56 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v3 02/30] drivers: hv: dxgkrnl: Driver initialization and
 loading
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, spronovo@microsoft.com,
        spronovo@linux.microsoft.com
References: <719fe06b7cbe9ac12fa4a729e810e3383ab421c1.1646163378.git.iourit@linux.microsoft.com>
 <739cf89e71ff72436d7ca3f846881dfb45d07a6a.1646163378.git.iourit@linux.microsoft.com>
 <Yh6F9cG6/SV6Fq8Q@kroah.com>
From:   Iouri Tarassov <iourit@linux.microsoft.com>
In-Reply-To: <Yh6F9cG6/SV6Fq8Q@kroah.com>
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


On 3/1/2022 12:45 PM, Greg KH wrote:
> On Tue, Mar 01, 2022 at 11:45:49AM -0800, Iouri Tarassov wrote:
> > - Create skeleton and add basic functionality for the
> > hyper-v compute device driver (dxgkrnl).
> > 
> > +
> > +#undef pr_fmt
> > +#define pr_fmt(fmt)	"dxgk: " fmt
>
> Use the dev_*() print functions, you are a driver, and you always have a
> pointer to a struct device.  There's no need to ever call pr_*().
>

There is no struct device during module initialization until the
/dev/dxg device is created. Is it ok to use pr_* functions in this case?
Should dev_*(NULL,...) be used? I see other drivers use the pr_*
functions in this case (mips.c as an example).


Thanks

Iouri

> thanks,
>
> greg k-h
