Return-Path: <linux-hyperv+bounces-1037-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8063C7F593F
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Nov 2023 08:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0E3B1C20B64
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Nov 2023 07:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFE6168C3;
	Thu, 23 Nov 2023 07:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1SKOsh9G"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED218E7;
	Wed, 22 Nov 2023 23:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=d7S/FKalzXE2uJiN7XbTBuXkMpogj8oWwgyCfRleg4Y=; b=1SKOsh9GVU8iqvK6R1fOs0sh2s
	CZSBcnZ7pXUvGsWz+Fb4qq1jTzZWzObgWnxlffh3BMb6ZxMI2zWRJE660LVnqHzZu7+i9rFd0bTXL
	4MCic54La6hsZw+eLdvJuCO9RPKQRPEnpGSMNGqGkYT+oDb/RIgvd96C2OzvhZya1aW4OlSZgfLUM
	k6+y+gbJgCZru0pSWsHcf/UnhuzCabugOeEJUNAchUOOBcXVaIgsZ9Tu/Jn0Sr16J5FJymlFmRr9s
	2ClOaRjsxbEQ18DwIdODqOJmMA1gXC6hrdaA+bNVYdv9YrqW0hCU2uTQt7dGDjDNpYWzdYDU8wLlO
	wzGESUBw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1r64C5-0042og-0b;
	Thu, 23 Nov 2023 07:32:13 +0000
Date: Wed, 22 Nov 2023 23:32:13 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"luto@kernel.org" <luto@kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"urezki@gmail.com" <urezki@gmail.com>,
	"lstoakes@gmail.com" <lstoakes@gmail.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
	"ardb@kernel.org" <ardb@kernel.org>,
	"jroedel@suse.de" <jroedel@suse.de>,
	"seanjc@google.com" <seanjc@google.com>,
	"rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
	"sathyanarayanan.kuppuswamy@linux.intel.com" <sathyanarayanan.kuppuswamy@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH v2 3/8] x86/mm: Remove "static" from vmap_pages_range()
Message-ID: <ZV7//Yjx6ngKSf0M@infradead.org>
References: <20231121212016.1154303-1-mhklinux@outlook.com>
 <20231121212016.1154303-4-mhklinux@outlook.com>
 <ZV2e/6qTJDkjYbfY@infradead.org>
 <SN6PR02MB41571479B921621EDE3BE2EFD4B9A@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB41571479B921621EDE3BE2EFD4B9A@SN6PR02MB4157.namprd02.prod.outlook.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Nov 23, 2023 at 12:24:49AM +0000, Michael Kelley wrote:
> > I really do not want to expose vmap_pages_range.  Please try to come up
> > with a good way to encapsulate your map at a certain address primitive
> > and implement it in vmalloc.c.
> 
> To clarify, is your concern narrowly about vmap_pages_range()
> specifically?

The prime concern is that it took a lot of effort to make
vmap_pages_range static and remove all the abuses.  I absolutely
object to undoing that.


