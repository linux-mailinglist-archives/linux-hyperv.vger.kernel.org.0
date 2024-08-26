Return-Path: <linux-hyperv+bounces-2863-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C9395E7EE
	for <lists+linux-hyperv@lfdr.de>; Mon, 26 Aug 2024 07:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C38261F2159E
	for <lists+linux-hyperv@lfdr.de>; Mon, 26 Aug 2024 05:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CF87711F;
	Mon, 26 Aug 2024 05:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="gSmBJB9l"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B236174416;
	Mon, 26 Aug 2024 05:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724650309; cv=none; b=nfCeW4TuoGRTaX5RHnT89fRrpW1brN3tJg3EtibmfAWLARB+EuE19oGAOqPcvRgF4KRMO9Cb7HudnksiwBKGoTyzZ1nwCMV3wrqfY+21fi3dH8W/8dZ/8cfxabZtlv8k4nkNZSZx+viqpLvV4ZqersgNGAa0WaTjFO2Z7AUrgug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724650309; c=relaxed/simple;
	bh=aUnRzuIF9ODDBptWo88nkk3Iuum9xrXdnNVXCtrGx1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WL+m28FrdW/SimimAe7QTilKMcJsySxfmH81/GmZIRXf9kEz27nBDio54W+IH1cAiemSH05XUO2s12TL5wTOw2eZ+yInrF/wmnZsaTz5nP4YzB0UQznPTB2vun5CkvNggTIcoaC6NZkFjRmlCct9PaBSIAocf5ky/kcDa5v5rFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=gSmBJB9l; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.95.75.183] (unknown [167.220.238.215])
	by linux.microsoft.com (Postfix) with ESMTPSA id 23EE720B7127;
	Sun, 25 Aug 2024 22:31:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 23EE720B7127
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1724650307;
	bh=gn2QC7ohh4dAjzXra3Zxf5kI2vdL4kPHJ76INGX5NEU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gSmBJB9lVJzeflZxJ+thanjrczRFwyWPsov5mu/9AVye3hGc77QvePrqSmjOE989o
	 l5/pCvr1rv224nCf3nWLpfUFPN0l8s4+sd3R/PyQSxjxCQnPJ8W4XhcVo310ujk0ie
	 Q43zIqHm9resk0iCLAlYJ9GbkX002T2dI7JE0nC8=
Message-ID: <0271e241-3bbb-4d88-8da5-d3d3b8b54e38@linux.microsoft.com>
Date: Mon, 26 Aug 2024 11:01:41 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] uio_hv_generic: Fix kernel NULL pointer dereference
 in hv_uio_rescind
To: Michael Kelley <mhklinux@outlook.com>,
 "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Saurabh Sengar <ssengar@linux.microsoft.com>
References: <20240822110912.13735-1-namjain@linux.microsoft.com>
 <20240822110912.13735-2-namjain@linux.microsoft.com>
 <SN6PR02MB4157FDCAE52019E13DB97229D48A2@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <SN6PR02MB4157FDCAE52019E13DB97229D48A2@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/25/2024 8:21 AM, Michael Kelley wrote:
> From: Naman Jain <namjain@linux.microsoft.com> Sent: Thursday, August 22, 2024 4:09 AM
>>
>> From: Saurabh Sengar <ssengar@linux.microsoft.com>
>>
>> For primary VMBus channels primary_channel pointer is always NULL. This
>> pointer is valid only for the secondry channels.
>>
>> Fix NULL pointer dereference by retrieving the device_obj from the parent
>> in the absence of a valid primary_channel pointer.
>>
>> Fixes: ca3cda6fcf1e ("uio_hv_generic: add rescind support")
>> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
>> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
>> ---
>>   drivers/uio/uio_hv_generic.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
>> index b45653752301..c99890c16d29 100644
>> --- a/drivers/uio/uio_hv_generic.c
>> +++ b/drivers/uio/uio_hv_generic.c
>> @@ -109,7 +109,8 @@ static void hv_uio_channel_cb(void *context)
>>    */
>>   static void hv_uio_rescind(struct vmbus_channel *channel)
>>   {
>> -	struct hv_device *hv_dev = channel->primary_channel->device_obj;
>> +	struct hv_device *hv_dev = channel->primary_channel ?
>> +				   channel->primary_channel->device_obj : channel->device_obj;
> 
> It looks to me like hv_uio_rescind() is called only for the primary
> channel. That makes sense, because waking up the reader should
> presumably be done once for the device, not once for each channel.
> 
> Rather than generalizing the function so it works for both primary
> and secondary channels, I'd suggest checking if the channel is a
> secondary channel. If so, output a warning message or do WARN(),
> and then return immediately, as some there's some kind of
> programming error.

Thanks for reviewing Michael. By design, there is different handling for 
secondary channel rescind in channel_mgmt.c [1] and this callback is not 
expected to be called. I will make the change in my next patch to make 
it a warning.


[1]
         } else if (channel->primary_channel != NULL) {
                 /*
                  * Sub-channel is being rescinded. Following is the channel
                  * close sequence when initiated from the driveri (refer to
                  * vmbus_close() for details):
                  * 1. Close all sub-channels first
                  * 2. Then close the primary channel.
                  */

> 
> Looking at the history of the code, it appears that rescinding a UIO
> device could never have worked. Is that your conclusion as well,
> or am I missing something?
> 
> Michael

Most likely, yes.


Regards,
Naman

