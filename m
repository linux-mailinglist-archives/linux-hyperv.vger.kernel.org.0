Return-Path: <linux-hyperv+bounces-511-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 031D37C4493
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Oct 2023 00:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 330F61C20964
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Oct 2023 22:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398E231584;
	Tue, 10 Oct 2023 22:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="CEl3o74J"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB2A29CE8
	for <linux-hyperv@vger.kernel.org>; Tue, 10 Oct 2023 22:49:51 +0000 (UTC)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4D5A792;
	Tue, 10 Oct 2023 15:49:50 -0700 (PDT)
Received: from [10.0.0.178] (c-76-135-56-23.hsd1.wa.comcast.net [76.135.56.23])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3767820B74C0;
	Tue, 10 Oct 2023 15:49:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3767820B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1696978189;
	bh=xNLCGvZHdU71qjHxRgA/1TNMVCHTexDMo8D59LMp6BY=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=CEl3o74J71QRcTdLqoPV7RImMOc17eR9UZgEQBih57CS6OUtzd9dL6Gs4mbxNvO4p
	 UIGFgIlIptnNftQv2rfctEATzmbOcxvAV8WIaaWIZUVN/syakprhhgeazRrZAbou1J
	 gyp8QkiN9EbrL3jsNwha+VZMO9D8arS1yiysou0c=
Message-ID: <50f1721f-64fb-49ff-9740-0dac7cf832c8@linux.microsoft.com>
Date: Tue, 10 Oct 2023 15:49:48 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/15] uapi: hyperv: Add mshv driver headers hvhdk.h,
 hvhdk_mini.h, hvgdk.h, hvgdk_mini.h
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
To: Greg KH <gregkh@linuxfoundation.org>, Wei Liu <wei.liu@kernel.org>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-arch@vger.kernel.org, patches@lists.linux.dev, mikelley@microsoft.com,
 kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
 apais@linux.microsoft.com, Tianyu.Lan@microsoft.com,
 ssengar@linux.microsoft.com, mukeshrathor@microsoft.com,
 stanislav.kinsburskiy@gmail.com, jinankjain@linux.microsoft.com,
 vkuznets@redhat.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, will@kernel.org,
 catalin.marinas@arm.com
References: <1692309711-5573-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1692309711-5573-14-git-send-email-nunodasneves@linux.microsoft.com>
 <ZN6m2gVmtVStuEfA@liuwe-devbox-debian-v2> <2023081923-crown-cake-79f7@gregkh>
 <c4482a6a-aed0-4750-aa1b-421f0e541cfa@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <c4482a6a-aed0-4750-aa1b-421f0e541cfa@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,SPF_HELO_PASS,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/25/2023 11:24 AM, Nuno Das Neves wrote:
> On 8/19/2023 3:26 AM, Greg KH wrote:
>>
>> My "strong" opinion is the one kernel development rule that we have,
>> "you can not break userspace".  So, if you change these
>> values/structures/whatever in the future, and userspace tools break,
>> that's not ok and the changes have to be reverted.
>>
>> If you can control both sides of the API here (with open tools that you
>> can guarantee everyone will always update to), then yes, you can change
>> the api in the future.
>>
> 
> This is true for us - we contribute and maintain support for this driver
> in Cloud Hypervisor[1], an open source VMM.
> 

Hi Greg,

Bringing up this discussion again so we can clear up any confusion on the
uapi headers in this patch set.

The headers consist of the ioctls in mshv.h, and the hypervisor ABIs in
the *hdk.h files. The ioctls depend on the hypervisor ABIs.

We will add (to the next version), an ioctl like KVM_GET_API_VERSION [1].
This will return a version number for the ioctl interface that increments
any time there is a breaking change. Userspace would be required to check
this before calling any other ioctl, and it can exit gracefully if there
is a mismatch.

That's how KVM evolved its userspace ABI. We want to use the same approach.

I also wanted to reiterate that we are the only maintainers and users of
the userspace code for this driver via Cloud Hypervisor [2]. We generate
rust bindings from these headers using bindgen [3].

Taking this into account, is the above a viable path for this patch set?

Thanks,
Nuno

[1] https://docs.kernel.org/virt/kvm/api.html#kvm-get-api-version
[2] https://github.com/cloud-hypervisor/cloud-hypervisor
[3] https://github.com/rust-lang/rust-bindgen


