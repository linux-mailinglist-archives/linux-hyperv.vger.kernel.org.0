Return-Path: <linux-hyperv+bounces-521-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AAB87C627B
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Oct 2023 03:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA4D728248A
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Oct 2023 01:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08457E4;
	Thu, 12 Oct 2023 01:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="JjpkcJ7c"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B2F65B
	for <linux-hyperv@vger.kernel.org>; Thu, 12 Oct 2023 01:56:07 +0000 (UTC)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3CCB3A9;
	Wed, 11 Oct 2023 18:56:06 -0700 (PDT)
Received: from [10.0.0.178] (c-76-135-56-23.hsd1.wa.comcast.net [76.135.56.23])
	by linux.microsoft.com (Postfix) with ESMTPSA id 076E220B74C1;
	Wed, 11 Oct 2023 18:56:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 076E220B74C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1697075765;
	bh=fkyT/+raROLPFX+mFalCuAsEjnzKBnBZN08qi2EQQx8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JjpkcJ7c5qt70zQwpK4E0IycHV3l0gNfupU+nYn1cRC728Ifrru4U/q4DOgTGPeYH
	 wlT+PMGaztmYkTN7pyPMX7orM3UjwBX6W+exe2QwuzpcxLOeZfjdQz6DPjnk0n3zt4
	 iHHtkcFRITS6p2zZBCsDuxlqqHOd4Srwo5Ha22QE=
Message-ID: <f94e3405-20c5-4701-8217-9542affef46f@linux.microsoft.com>
Date: Wed, 11 Oct 2023 18:56:04 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/15] uapi: hyperv: Add mshv driver headers hvhdk.h,
 hvhdk_mini.h, hvgdk.h, hvgdk_mini.h
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
 patches@lists.linux.dev, mikelley@microsoft.com, kys@microsoft.com,
 haiyangz@microsoft.com, decui@microsoft.com, apais@linux.microsoft.com,
 Tianyu.Lan@microsoft.com, ssengar@linux.microsoft.com,
 mukeshrathor@microsoft.com, stanislav.kinsburskiy@gmail.com,
 jinankjain@linux.microsoft.com, vkuznets@redhat.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
 will@kernel.org, catalin.marinas@arm.com
References: <1692309711-5573-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1692309711-5573-14-git-send-email-nunodasneves@linux.microsoft.com>
 <ZN6m2gVmtVStuEfA@liuwe-devbox-debian-v2> <2023081923-crown-cake-79f7@gregkh>
 <c4482a6a-aed0-4750-aa1b-421f0e541cfa@linux.microsoft.com>
 <50f1721f-64fb-49ff-9740-0dac7cf832c8@linux.microsoft.com>
 <2023101133-blade-diary-11e4@gregkh>
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <2023101133-blade-diary-11e4@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/10/2023 11:42 PM, Greg KH wrote:
> On Tue, Oct 10, 2023 at 03:49:48PM -0700, Nuno Das Neves wrote:
>> On 8/25/2023 11:24 AM, Nuno Das Neves wrote:
>>> On 8/19/2023 3:26 AM, Greg KH wrote:
>>>>
>>>> My "strong" opinion is the one kernel development rule that we have,
>>>> "you can not break userspace".  So, if you change these
>>>> values/structures/whatever in the future, and userspace tools break,
>>>> that's not ok and the changes have to be reverted.
>>>>
>>>> If you can control both sides of the API here (with open tools that you
>>>> can guarantee everyone will always update to), then yes, you can change
>>>> the api in the future.
>>>>

We control both sides of the API. The code is open. No one else can use it
today, therefore we can guarantee all the users will stay updated.

> Just submit your fixed up patch series based on the previous review
> comments and it will be reviewed again, just like all kernel patches
> are.

I will do that.

> Perhaps you all should take the time to do some kernel patch reviews of
> other stuff sent to the mailing lists to get an idea of how this whole
> process works, and to get better integrated into the kernel development
> community,

That is a good suggestion, I will do that.

> before dumping a huge patchset on us with lots of process
> questions like this?  Why are you asking the community to do a lot of
> work and hand-holding when you aren't helping others out as well?

I take your point, sorry my questions came off that way. I will work to
improve on that :)

Thanks,
Nuno

