Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2655725518D
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Aug 2020 01:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbgH0XaB (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 27 Aug 2020 19:30:01 -0400
Received: from linux.microsoft.com ([13.77.154.182]:47858 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgH0XaA (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 27 Aug 2020 19:30:00 -0400
Received: from [192.168.1.17] (50-47-107-221.evrt.wa.frontiernet.net [50.47.107.221])
        by linux.microsoft.com (Postfix) with ESMTPSA id E933820B7178;
        Thu, 27 Aug 2020 16:29:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E933820B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1598571000;
        bh=wuKHk2etmpOkKZ+mX7e+4wCZgquz5pl8IyY73pe5ZGE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=mdsSv4OkGJMTMEOR4egTE96ddEeTMglYTT1hGi4Mg8TENH/qtgadEXQL0r3OVgcQD
         52TN+lI4fLsEvE8/gDF2BhNlrwpElC61jUMDzf2H9Y4Cxf2BW5W/Y49hGX5a0mV9Ws
         CKRpea0tNFI2a/iRndFW6ApzdMv4xJh4gtCcnAm0=
Subject: Re: [PATCH 1/4] drivers: hv: dxgkrnl: core code
To:     Greg KH <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, iourit@microsoft.com,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
References: <20200814123856.3880009-1-sashal@kernel.org>
 <20200814123856.3880009-2-sashal@kernel.org>
 <20200814125528.GA56456@kroah.com>
From:   Iouri Tarassov <iourit@linux.microsoft.com>
Message-ID: <58011269-e910-b3e4-2a3c-552b08c90574@linux.microsoft.com>
Date:   Thu, 27 Aug 2020 16:29:59 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200814125528.GA56456@kroah.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 8/14/2020 5:55 AM, Greg KH wrote:
> On Fri, Aug 14, 2020 at 08:38:53AM -0400, Sasha Levin wrote:
> > Add support for a Hyper-V based vGPU implementation that exposes the
> > DirectX API to Linux userspace.
> > 
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
>
> Better, but what is this mess:
>
> > +#define ISERROR(ret)					(ret < 0)

The VM bus messages return the NTSTATUS error code from the host. 
NTSTATUS is integer and the positive values indicate success.
The success error code needs to be returned by IOCTLs to the DxCore 
applications. The ISERROR() macro is used in places where the NTSTATUS 
success code could be returned from a function. "if (ret)" cannot be 
used. I will add a comment to the macro in the next patch.

>
> ?
>
> > +#define EINTERNALERROR					EINVAL
This macro will be removed in the next patch
> And that?
>
> > +
> > +#define DXGKRNL_ASSERT(exp)
> > +#define UNUSED(x) (void)(x)
The UNUSED macro will be removed.
The DXGKRNL_ASSERT() macro will be changed to generate a memory dump and 
BUG_ON when DXGDEBUG is enabled. It is used to catch internal errors in 
the debug code. There will be no bugcheck in the released driver.
>
> Ick, no, please.
>
> > +#undef pr_fmt
>
> In a .h file?
>
> > +#define pr_fmt(fmt)	"dxgk:err: " fmt
> > +#define pr_fmt1(fmt)	"dxgk: " fmt
> > +#define pr_fmt2(fmt)	"dxgk:    " fmt
This will be fixed in the next patch set.
> Why?
>
> > +
> > +#define DXGKDEBUG 1
> > +/* #define USEPRINTK 1 */
> > +
> > +#ifndef DXGKDEBUG
> > +#define TRACE_DEBUG(...)
> > +#define TRACE_DEFINE(...)
> > +#define TRACE_FUNC_ENTER(...)
> > +#define TRACE_FUNC_EXIT(...)
>
> No, please do not to custom "trace" printk messages, that is what ftrace
> is for, no individual driver should ever need to do that.
>
> Just use the normal dev_*() calls for error messages and the like, do
> not try to come up with a custom tracing framework for one tiny
> individual driver.  If every driver in kernel did that, we would have a
> nightmare...
I understand the concern. This will be fixed later when we learn and 
pick the final tracing technology for the driver. The current 
implementation allows the hardware vendors to quickly identify issues 
without learning about ftrace. They just need to enable the WSL debug 
console and mount debugfs.
> thanks,
>
> greg k-h
>
Thank you for your time and good comments.
Iouri

