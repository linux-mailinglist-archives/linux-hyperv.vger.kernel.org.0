Return-Path: <linux-hyperv+bounces-1003-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1647F3324
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Nov 2023 17:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CA311C21CC3
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Nov 2023 16:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E23B559174;
	Tue, 21 Nov 2023 16:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-hyperv@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 296D9CB;
	Tue, 21 Nov 2023 08:06:25 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B4B07FEC;
	Tue, 21 Nov 2023 08:07:11 -0800 (PST)
Received: from [10.1.32.63] (010265703453.arm.com [10.1.32.63])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3BD693F6C4;
	Tue, 21 Nov 2023 08:06:17 -0800 (PST)
Message-ID: <e926d2d8-8209-4c0f-a0cb-dcea4edf839e@arm.com>
Date: Tue, 21 Nov 2023 16:06:15 +0000
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/17] Solve iommu probe races around iommu_fwspec
Content-Language: en-GB
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: acpica-devel@lists.linux.dev, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Albert Ou <aou@eecs.berkeley.edu>, asahi@lists.linux.dev,
 Catalin Marinas <catalin.marinas@arm.com>, Dexuan Cui <decui@microsoft.com>,
 devicetree@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
 Frank Rowand <frowand.list@gmail.com>, Hanjun Guo <guohanjun@huawei.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, iommu@lists.linux.dev,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, Joerg Roedel <joro@8bytes.org>,
 "K. Y. Srinivasan" <kys@microsoft.com>, Len Brown <lenb@kernel.org>,
 linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-hyperv@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-snps-arc@lists.infradead.org,
 linux-tegra@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Hector Martin
 <marcan@marcan.st>, Palmer Dabbelt <palmer@dabbelt.com>,
 patches@lists.linux.dev, Paul Walmsley <paul.walmsley@sifive.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Robert Moore <robert.moore@intel.com>, Rob Herring <robh+dt@kernel.org>,
 Sudeep Holla <sudeep.holla@arm.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Sven Peter <sven@svenpeter.dev>, Thierry Reding <thierry.reding@gmail.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Krishna Reddy <vdumpa@nvidia.com>, Vineet Gupta <vgupta@kernel.org>,
 virtualization@lists.linux.dev, Wei Liu <wei.liu@kernel.org>,
 Will Deacon <will@kernel.org>, =?UTF-8?Q?Andr=C3=A9_Draszik?=
 <andre.draszik@linaro.org>, Lu Baolu <baolu.lu@linux.intel.com>,
 Christoph Hellwig <hch@lst.de>, Jerry Snitselaar <jsnitsel@redhat.com>,
 Moritz Fischer <mdf@kernel.org>, Zhenhua Huang <quic_zhenhuah@quicinc.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Rob Herring <robh@kernel.org>
References: <0-v2-36a0088ecaa7+22c6e-iommu_fwspec_jgg@nvidia.com>
 <1316b55e-8074-4b2f-99df-585df2f3dd06@arm.com> <ZVTlYqnnHQUKG6T8@nvidia.com>
 <6442d24b-6352-46e9-89e0-72d4a493f77c@arm.com> <ZVWXvqQbZrwyEgrL@nvidia.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <ZVWXvqQbZrwyEgrL@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-11-16 4:17 am, Jason Gunthorpe wrote:
> On Wed, Nov 15, 2023 at 08:23:54PM +0000, Robin Murphy wrote:
>> On 2023-11-15 3:36 pm, Jason Gunthorpe wrote:
>>> On Wed, Nov 15, 2023 at 03:22:09PM +0000, Robin Murphy wrote:
>>>> On 2023-11-15 2:05 pm, Jason Gunthorpe wrote:
>>>>> [Several people have tested this now, so it is something that should sit in
>>>>> linux-next for a while]
>>>>
>>>> What's the aim here? This is obviously far, far too much for a
>>>> stable fix,
>>>
>>> To fix the locking bug and ugly abuse of dev->iommu?
>>
>> Fixing the locking can be achieved by fixing the locking, as I have now
>> demonstrated.
> 
> Obviously. I rejected that right away because of how incredibly
> wrongly layered and hacky it is to do something like that.

What, and dressing up the fundamental layering violation by baking it 
even further into the API flow, while still not actually fixing it or 
any of its *other* symptoms, is somehow better?

Ultimately, this series is still basically doing the same thing my patch 
does - extending the scope of the existing iommu_probe_device_lock hack 
to cover fwspec creation. A hack is a hack, so frankly I'd rather it be 
simple and obvious and look like one, and being easy to remove again is 
an obvious bonus too.

>>> I haven't seen patches or an outline on what you have in mind though?
>>>
>>> In my view I would like to get rid of of_xlate(), at a minimum. It is
>>> a micro-optimization I don't think we need. I see a pretty
>>> straightforward path to get there from here.
>>
>> Micro-optimisation!? OK, I think I have to say it. Please stop trying to
>> rewrite code you don't understand.
> 
> I understand it fine. The list of (fwnode_handle, of_phandle_args)
> tuples doesn't change between when of_xlate is callled and when probe
> is called. Probe can have the same list. As best I can tell the extra
> ops avoids maybe some memory allocation, maybe an extra iteration.
> 
> What it does do is screw up alot of the drivers that seem to want to
> allocate the per-device data in of_xlate and make it convoluted and
> memory leaking buggy on error paths.
> 
> So, I would move toward having the driver's probe invoke a helper like:
> 
>     iommu_of_xlate(dev, fwspec, &per_fwnode_function, &args);
> 
> Which generates the same list of (fwnode_handle, of_phandle_args) that
> was passed to of_xlate today, but is ordered sensibly within the
> sequence of probe for what many drivers seem to want to do.

Grep for of_xlate. It is a standard and well-understood callback pattern 
for a subsystem to parse a common DT binding and pass a driver-specific 
specifier to a driver to interpret. Or maybe you just have a peculiar 
definition of what you think "micro-optimisation" means? :/

> So, it is not so much that that the idea of of_xlate goes away, but
> the specific op->of_xlate does, it gets shifted into a helper that
> invokes the same function in a more logical spot.

I'm curious how you imagine an IOMMU driver's ->probe function could be 
called *before* parsing the firmware to work out what, if any, IOMMU, 
and thus driver, a device is associated with. Unless you think we should 
have the horrible perf model of passing the device to *every* registered 
->probe callback in turn until someone claims it. And then every driver 
has to have identical boilerplate to go off and parse the generic 
"iommus" binding... which is the whole damn reason for *not* going down 
that route and instead using an of_xlate mechanism in the first place.

> The per-device data can be allocated at the top of probe and passed
> through args to fix the lifetime bugs.
> 
> It is pretty simple to do.

I believe the kids these days would say "Say you don't understand the 
code without saying you don't understand the code."

>> Most of this series constitutes a giant sweeping redesign of a whole bunch
>> of internal machinery to permit it to be used concurrently, where that
>> concurrency should still not exist in the first place because the thing that
>> allows it to happen also causes other problems like groups being broken.
>> Once the real problem is fixed there will be no need for any of this, and at
>> worst some of it will then actually get in the way.
> 
> Not quite. This decouples two unrelated things into seperate
> concerns. It is not so much about the concurrency but removing the
> abuse of dev->iommu by code that has no need to touch it at all.

Sorry, the "abuse" of storing IOMMU-API-specific data in the place we 
intentionally created to consolidate all the IOMMU-API-specific data 
into? Yes, there is an issue with the circumstances in which this data 
is sometimes accessed, but as I'm starting to tire of repeating, that 
issue fundamentally dates back to 2017, and the implications were 
unfortunately overlooked when dev->iommu was later introduced and fwspec 
moved into it (since the non-DT probing paths still worked as originally 
designed). Pretending that dev->iommu is the issue here is missing the 
point.

> Decoupling makes moving code around easier since the relationships are
> easier to reason about.

Again with the odd definitions of "easier". You know what I think is 
easy? Having a thing be in the obvious place where it should be (but 
used in the way that was intended). What I would consider objectively 
less easy is having a thing sometimes be there but sometimes be 
somewhere else with loads more API machinery to juggle between the two. 
Especially when once again, that machinery is itself prone to new bugs.

Once again you've got hung up on one particular detail of one symptom of 
the *real* issue, so although I can see and follow your chain of 
reasoning, the fact that it starts from the wrong place makes it not 
particularly useful in the bigger picture.

> You can still allocated a fwnode, populate it, and do the rest of the
> flow under a probe function just fine.
>   
>> I feel like I've explained it many times already, but what needs to happen
>> is for the firmware parsing and of_xlate stage to be initiated by
>> __iommu_probe_device() itself.
> 
> Yes, OK I see. I don't see a problem, I think this still a good
> improvement even in that world it is undesirable to use dev->iommu as
> a temporary, even if the locking can work.
> 
>> ever allowed to get it landed...) which gets to the state of
>> expecting to
> 
> Repost it? Rc1 is out and you need to add one hunk to the new user
> domain creation in iommufd.

Well yeah, I'm trying to get that rebase finished (hence why I'm finding 
broken IOMMUFD selftests), but as always I'm also busy with a lot of 
other non-upstream things, and every time I have managed to do it so far 
this year it's ended up being blocked by conflicting changes, so I 
reserve my optimism...

>> start from a fwspec. Then it's a case of shuffling around what's currently
>> in the bus_type dma_configure methods such that point is where the fwspec is
>> created as well, and the driver-probe-time work is almost removed except for
>> still deferring if a device is waiting for its IOMMU instance (since that
>> instance turning up and registering will retrigger the rest itself). And
>> there at last, a trivial lifecycle and access pattern for dev->iommu (with
>> the overlapping bits of iommu_fwspec finally able to be squashed as well),
>> and finally an end to 8 long and unfortunate years of calling things in the
>> wrong order in ways they were never supposed to be.
> 
> Having just gone through this all in detail I don't think it is as
> entirely straightforward as this, the open coded callers to
> of_dma_configure() are not going to be so nice to unravel.

I've only had this turning over in the back of my mind for about the 
last 4 years now, so I think I have a good understanding of what to 
expect, thanks.

Robin.

