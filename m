Return-Path: <linux-hyperv+bounces-89-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C5B7A138E
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 Sep 2023 04:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97BCB1C20B9E
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 Sep 2023 02:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D769DA32;
	Fri, 15 Sep 2023 02:07:08 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB077658
	for <linux-hyperv@vger.kernel.org>; Fri, 15 Sep 2023 02:07:06 +0000 (UTC)
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4A31BF8;
	Thu, 14 Sep 2023 19:07:05 -0700 (PDT)
Received: from [172.27.2.41] ([98.35.210.218])
	(authenticated bits=0)
	by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 38F265Wd3668683
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 14 Sep 2023 19:06:06 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 38F265Wd3668683
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2023091101; t=1694743567;
	bh=pS+FaX3FGPx0JfqHE/l2ITnl7xmsLE2z552abw2UC+0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=L9Tn4bNWud/CxiGNp8dzV9DjK/XgpKI9glMVqLtI284PNIM+SU+lt6/HVStRqyVH+
	 Wa217xj/vgHHveKFL3+RFza4ZxqOYDCyK118q8ZMfUs6FM1DJ3XmbNm8j7tboNUv35
	 CaKawJfEqcY1xG1CRP25CZItxE2Tt6Syd+xn3AuaPTvjnDrojd6kvP5LvdtaWjPr9z
	 z+1v6TEBpYVeuLyH+uat0FpanQYtkD2FVdr8ypVLKEBPypEZsGMwF5hBYQjJB99Bht
	 toS9X9qEIa/l11zjrnNpZhnSWZKp+DJQXz/2flAJ8ojaF0zHwqIVFcnJwYgDHpAcjg
	 dyKUsdqLoIv4w==
Message-ID: <b05e3092-8ba3-f4e1-b5a3-2125944936fd@zytor.com>
Date: Thu, 14 Sep 2023 19:06:04 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v10 03/38] x86/msr: Add the WRMSRNS instruction support
Content-Language: en-US
To: andrew.cooper3@citrix.com, Thomas Gleixner <tglx@linutronix.de>,
        Xin Li <xin3.li@intel.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        linux-hyperv@vger.kernel.org, kvm@vger.kernel.org,
        xen-devel@lists.xenproject.org
Cc: mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, luto@kernel.org, pbonzini@redhat.com,
        seanjc@google.com, peterz@infradead.org, jgross@suse.com,
        ravi.v.shankar@intel.com, mhiramat@kernel.org, jiangshanlai@gmail.com
References: <20230914044805.301390-1-xin3.li@intel.com>
 <20230914044805.301390-4-xin3.li@intel.com>
 <6f5678ff-f8b1-9ada-c8c7-f32cfb77263a@citrix.com> <87y1h81ht4.ffs@tglx>
 <7ba4ae3e-f75d-66a8-7669-b6eb17c1aa1c@citrix.com> <87v8cc1ehe.ffs@tglx>
 <50e96f85-66f8-2a4f-45c9-a685c757bb28@citrix.com>
 <5cf50d76-8e18-2863-4889-70e9c18298a1@zytor.com>
 <af5990d5-58d5-9109-b37b-1f696a43fe86@citrix.com>
From: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <af5990d5-58d5-9109-b37b-1f696a43fe86@citrix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/14/23 18:46, andrew.cooper3@citrix.com wrote:
> On 15/09/2023 1:38 am, H. Peter Anvin wrote:
>> On 9/14/23 17:33, andrew.cooper3@citrix.com wrote:
>>>
>>> It's an assumption about what "definitely won't" be paravirt in the
>>> future.
>>>
>>> XenPV stack handling is almost-FRED-like and has been for the better
>>> part of two decades.
>>>
>>> You frequently complain that there's too much black magic holding XenPV
>>> together.  A paravirt-FRED will reduce the differences vs native
>>> substantially.
>>>
>>
>> Call it "paravirtualized exception handling." In that sense, the
>> refactoring of the exception handling to benefit FRED is definitely
>> useful for reducing paravirtualization. The FRED-specific code is
>> largely trivial, and presumably what you would do is to replace the
>> FRED wrapper with a Xen wrapper and call the common handler routines.
> 
> Why do only half the job?
> 
> There's no need for any Xen wrappers at all when XenPV can use the
> native FRED paths, as long as ERETU, ERETS and the relevant MSRs can be
> paravirt (sure - with an interface that sucks less than right now) so
> they're not taking the #GP/emulate in Xen path.
> 
> And this can work on all hardware with a slightly-future version of Xen
> and Linux, because it's just a minor adjustment to how Xen writes the
> exception frame on the guests stack as part of event delivery.
> 

It's not about doing "half the job", it's about using the proper 
abstraction mechanism. By all means, if you can join the common code 
flow earlier, do so, but paravirtualizing the entry/exit stubs which is 
the *only* place ERETU and ERETS show up is just crazy.

Similarly, nearly all the MSRs are just configuration setup. The only 
ones which have any kind of performance relevance is the stack setup (RSP0).

	-hpa


