Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70C172551EC
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Aug 2020 02:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbgH1AZY (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 27 Aug 2020 20:25:24 -0400
Received: from linux.microsoft.com ([13.77.154.182]:55768 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbgH1AZY (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 27 Aug 2020 20:25:24 -0400
Received: from [192.168.1.17] (50-47-107-221.evrt.wa.frontiernet.net [50.47.107.221])
        by linux.microsoft.com (Postfix) with ESMTPSA id D6B1E20B7178;
        Thu, 27 Aug 2020 17:25:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D6B1E20B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1598574324;
        bh=ZuPP2sDGF4DA7iI6cuuRyzGh+0z8ccGr3KwC1RdsDF0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=a/Vp8fmtmRgXvQfOIFkxmif6CUiNyoI2EybhMM2JJ+SIzOfPKxL7F8yQzAapN7bLe
         Jx1Z2EfOXctZUoVcGEsh3C5vGxJebIOZ6oeWDqxSC1xRGTQG0Ks/vk1MG7V+POxHkN
         3ngUR8au2AkcutNEnbgQr10kpYT+Wngic5uzSyE8=
Subject: Re: [PATCH 1/4] drivers: hv: dxgkrnl: core code
To:     Pavel Machek <pavel@denx.de>, Sasha Levin <sashal@kernel.org>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, gregkh@linuxfoundation.org,
        iourit@microsoft.com, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org
References: <20200814123856.3880009-1-sashal@kernel.org>
 <20200814123856.3880009-2-sashal@kernel.org> <20200821135340.GA4067@bug>
From:   Iouri Tarassov <iourit@linux.microsoft.com>
Message-ID: <054abab3-748e-c56b-526a-1b1734a9eaf7@linux.microsoft.com>
Date:   Thu, 27 Aug 2020 17:25:23 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200821135340.GA4067@bug>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Pavel,

Thanks for your time reviewing the driver.

On 8/21/2020 6:53 AM, Pavel Machek wrote:
> On Fri 2020-08-14 08:38:53, Sasha Levin wrote:
> > Add support for a Hyper-V based vGPU implementation that exposes the
> > DirectX API to Linux userspace.
>
> NAK.
>
> Kernel APIs should be documented. ... in tree and with suitable license.
We are considering to add required documentation. The design is that the 
driver IOCTLs will not be called directly by user mode drivers or 
applications. They will instead link with libdxcore.so and use the 
D3DKMT* interface to send requests to the driver.  libdxcore will 
translate the request to driver IOCTLs and do some additional work. For 
example, it will translate the path of the user mode driver name to the 
Linux namespace. The D3DKMTinterface is documented on MSDN. Do you 
suggest that the IOCTL interface needs to be documented or the D3DKMT 
interface?
> 	
> > +int dxgadapter_init(struct dxgadapter *adapter, struct hv_device *hdev)
> > +{
> > +	int ret = 0;
> > +	char s[80];
> > +
> > +	UNUSED(s);
>
> What is going on here?
This is a mistake, which will be fixed.
>
> > +{
> > +	struct dxgprocess_adapter *adapter_info = dxgmem_alloc(process,
> > +							       DXGMEM_PROCESS_ADAPTER,
> > +							       sizeof
> > +							       (*adapter_info));
>
> We normally use kernel functions in kernel code.
Using a custom memory allocation function allows us to track memory 
allocations per DXGPROCESS and catch memory leaks when a DXGPROCESS is 
destroyed or when the driver is unloaded. It also allows to easily 
change the memory allocation implementation if needed.
>
> > +	dxgmutex_unlock(&device->adapter_info->device_list_mutex);
>
> And you should not have private locking primitives, either.
This is done to allow the implementation of custom lock order 
verification. We learnt recently about lock dependency checking in 
kernel and will evaluate if it can replace the custom lock order 
verification.
>
> > +bool dxghwqueue_acquire_reference(struct dxghwqueue *hwqueue)
> > +{
> > +	return refcount_inc_not_zero(&hwqueue->refcount);
> > +}
>
> Midlayers are evil.
I strongly agree in general, but think that in our case the layers are 
very small. It allows to quickly find all places where a 
reference/dereference on an object is done and addition of debug tracing 
to catch errors.
>
> Best regards,
> 									Pavel

Thank you
Iouri


