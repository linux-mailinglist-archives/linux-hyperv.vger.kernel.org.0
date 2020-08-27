Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC8C253AE4
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Aug 2020 02:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbgH0AMC (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 26 Aug 2020 20:12:02 -0400
Received: from linux.microsoft.com ([13.77.154.182]:51128 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgH0AMC (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 26 Aug 2020 20:12:02 -0400
Received: from [192.168.1.17] (50-47-107-221.evrt.wa.frontiernet.net [50.47.107.221])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8C58B20B4908;
        Wed, 26 Aug 2020 17:12:01 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8C58B20B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1598487121;
        bh=0dvPI765NajRcWBSg7swUIq85twTRPdWiXoMWNw5qGI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=CS5VVPTsWF2xtc5sqk7sAj11dKrMOZXp/3NiK8c6qVD8Gbwfc89/KKPiRcKniQDD0
         6j3lvvsBowGfaFbqlhjDpK6rk/zOqKAT6A7MgF8qAGXek5164+QQwrYKEGnDpxxcZ1
         Q4c/7kdO/Eqc2BcgYnA/1gyi59Wzxh7cIj2OfnvY=
Subject: Re: [PATCH 1/4] drivers: hv: dxgkrnl: core code
To:     iouri_t@hotmail.com
Cc:     haiyangz@microsoft.com, sthemmin@microsoft.com,
        gregkh@linuxfoundation.org, iourit@microsoft.com,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
References: <20200814123856.3880009-1-sashal@kernel.org>
 <20200814123856.3880009-2-sashal@kernel.org>
 <20200814131839.u2vy52mtiejtuwcg@liuwe-devbox-debian-v2>
From:   Iouri Tarassov <iourit@linux.microsoft.com>
Message-ID: <25b6a68b-1e3c-f2a7-7924-18397a00843c@linux.microsoft.com>
Date:   Wed, 26 Aug 2020 17:12:01 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200814131839.u2vy52mtiejtuwcg@liuwe-devbox-debian-v2>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hello

On 8/14/2020 6:18 AM, Wei Liu wrote:
> On Fri, Aug 14, 2020 at 08:38:53AM -0400, Sasha Levin wrote:
> [...]
> > +
> > +#include "dxgkrnl.h"
> > +
> > +int dxgadapter_init(struct dxgadapter *adapter, struct hv_device *hdev)
> > +{
> > +	int ret = 0;
> > +	char s[80];
> > +
> > +	UNUSED(s);
>
> If s is not used, why not just remove it?
>
> Indeed it is not used anywhere in this function. That saves you 80 bytes
> on stack.
>
> > +static int dxgk_destroy_hwcontext(struct dxgprocess *process,
> > +					      void *__user inargs)
> > +{
> > +	/* This is obsolete entry point */
> > +	return ENOTTY;
> > +}
> > +
>
> Other places have been using negative numbers for errors. I guess you
> want -ENOTTY here too.
>
> Wei.
>
>
