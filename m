Return-Path: <linux-hyperv+bounces-130-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E8B7A87C1
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 Sep 2023 17:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92F951C20EC5
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 Sep 2023 15:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8B93B2AC;
	Wed, 20 Sep 2023 15:01:10 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994D229A1
	for <linux-hyperv@vger.kernel.org>; Wed, 20 Sep 2023 15:01:08 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58A49F;
	Wed, 20 Sep 2023 08:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rWkB7EDNng9M39a7Z5ofZ+3H/5SPbGNHhMrFP2dtGbY=; b=gbBwTJ41KAmMXmjfJHdJuM7m3X
	hExgqa3hFHE8oGJcBGAwWV1T/3bCar8Q/4J6kCFh3lPc6C1w5JSzk0t/sppfTeuOuPqbkwJYbcQCA
	Msu0ZRdMcoOovrESWX3e875PmIMIBSrS4FtQ6mkCe/JdrliuRxauJrt0MJcZjPdo7EqSm+fAmOhwe
	trz1GroFYHwCKDYsYL97k/F/mFR5NvDSXdmntjJExEs8ifO6+1NTZod2ifPXoYaZVSZxEMeqngWfs
	NrrhUFV7r0Gl9W5Rr7JEAOnQhVOOIU0Ua8nWwf0A1uLrrKzCuLGBjfkYGwTe+kgu4Pq9ruGUQXJ33
	qvYYaX6A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qiygf-00Efi6-1Z;
	Wed, 20 Sep 2023 15:00:24 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8FF67300348; Wed, 20 Sep 2023 17:00:22 +0200 (CEST)
Date: Wed, 20 Sep 2023 17:00:22 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: andrew.cooper3@citrix.com
Cc: "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
	Xin Li <xin3.li@intel.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
	linux-hyperv@vger.kernel.org, kvm@vger.kernel.org,
	xen-devel@lists.xenproject.org, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, luto@kernel.org,
	pbonzini@redhat.com, seanjc@google.com, jgross@suse.com,
	ravi.v.shankar@intel.com, mhiramat@kernel.org,
	jiangshanlai@gmail.com
Subject: Re: [PATCH v10 03/38] x86/msr: Add the WRMSRNS instruction support
Message-ID: <20230920150022.GH424@noisy.programming.kicks-ass.net>
References: <20230914044805.301390-1-xin3.li@intel.com>
 <20230914044805.301390-4-xin3.li@intel.com>
 <6f5678ff-f8b1-9ada-c8c7-f32cfb77263a@citrix.com>
 <87y1h81ht4.ffs@tglx>
 <7ba4ae3e-f75d-66a8-7669-b6eb17c1aa1c@citrix.com>
 <0e7d37db-e1af-ac40-6eca-5565d1bebcde@zytor.com>
 <6575702e-fea5-61b2-dd61-7b556a8603e8@citrix.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6575702e-fea5-61b2-dd61-7b556a8603e8@citrix.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 15, 2023 at 02:16:50AM +0100, andrew.cooper3@citrix.com wrote:

> Juergen has already done the work to delete one of these two patching
> mechanisms and replace it with the other.
> 
> https://lore.kernel.org/lkml/a32e211f-4add-4fb2-9e5a-480ae9b9bbf2@suse.com/
> 
> Unfortunately, it's only collecting pings and tumbleweeds.

Fixed that...

