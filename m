Return-Path: <linux-hyperv+bounces-837-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B2FF7E7C72
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Nov 2023 14:17:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C091B20D13
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Nov 2023 13:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520B018E39;
	Fri, 10 Nov 2023 13:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="H4A14T6Y"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8136218E16
	for <linux-hyperv@vger.kernel.org>; Fri, 10 Nov 2023 13:17:49 +0000 (UTC)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E796371FB;
	Fri, 10 Nov 2023 05:17:47 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C731640E014B;
	Fri, 10 Nov 2023 13:17:44 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 28bxGd9qN_tK; Fri, 10 Nov 2023 13:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1699622262; bh=tYlpue02F0EOT6WHd1ATXudFmUaSMZszGKV2T11cukw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H4A14T6YjpBq3aaoWJpbqNbZAJChQDjs9B+fOcBDIChZ5NURA1+KAOqxtrdgozdJl
	 Q96oIXWS1ploh5MuULtWWK5TVjk6sEkvAfbBdZwqGiz3iRA0twaSgoqKJiE/GYeCrF
	 biyvql8rWSsnPW298ocYUIu6m5bjYeBVZUMFAfeT+LCAi5yhV9Vd2HpRyuupztB38+
	 E/eeeVcB8A39/JVhJIsWAcKxGxiykbNR8zY68EEMN9g4rokstJzY9rvCiy5eotiVk3
	 Sf1JbFwhMZwziK5XYo7yFyam4Ec4TLUkhBkm9vcOYz3RghueBI3Cb3Hmg7lWnF3+Dt
	 WXZQAp7gq2fiojrQW71u86yjGKC1E/juckcWnRG/ulsnprjHRk/M/MruK0td+QXOhi
	 zCWFKtOHHgNKllX6nX6QkMXamxcMsK5SWP+gh3JYaZLFFL4WfZPsEfDt3ad/gTKlp5
	 CTun8Zm2NwVguuutw8hJOlqkZjoZByelD/coCmhpke6zn4uwnIH5dpBUiMKSzDQbub
	 rwf6IJjh+rmRmO9gyjHmrB0wc0FFlzvlD3wq17gAHHh5ss4kALiyryXSPAr4+sGQxI
	 FNNWjYTBDAQVDY/BozSWlFyO0hCt0z2AAigkMEmws0oDO+VlhDgpbaTLrQ5ltXrZig
	 LMGuIb/MeRKcBz97vPkUqFmU=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 45BC840E0032;
	Fri, 10 Nov 2023 13:17:20 +0000 (UTC)
Date: Fri, 10 Nov 2023 14:17:15 +0100
From: Borislav Petkov <bp@alien8.de>
To: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
Cc: Dave Hansen <dave.hansen@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
	Michael Kelley <mhklinux@outlook.com>,
	Dexuan Cui <decui@microsoft.com>, linux-hyperv@vger.kernel.org,
	stefan.bader@canonical.com, tim.gardner@canonical.com,
	roxana.nicolescu@canonical.com, cascardo@canonical.com,
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	kirill.shutemov@linux.intel.com, sashal@kernel.org
Subject: Re: [PATCH] x86/mm: Check cc_vendor when printing memory encryption
 info
Message-ID: <20231110131715.GAZU4tW2cJrGoLPmKl@fat_crate.local>
References: <1699546489-4606-1-git-send-email-jpiotrowski@linux.microsoft.com>
 <16ea75a9-8c94-4665-ae04-32d08aa4ebb2@intel.com>
 <58abbc79-64d4-41f9-9fd2-1de7826fbbf6@linux.microsoft.com>
 <ee9de366-6027-495a-98d9-b8b0cd866bf2@intel.com>
 <df95817a-4859-443a-9ac2-b09f102aff30@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <df95817a-4859-443a-9ac2-b09f102aff30@linux.microsoft.com>

On Thu, Nov 09, 2023 at 07:41:33PM +0100, Jeremi Piotrowski wrote:
> tdx_early_init() changes kernel behavior with the assumption that it
> can talk directly to the TD module or change page visibility in
> a certain way, instead of talking to a paravisor. So that CPUID is
> hidden to prevent this.  Otherwise tdx_early_init() would need to be
> modified to check "am I running with TD partitioning and if so
> - switch to other implementations".

Here we go with the virt zoo again. If you hide TDX_CPUID_LEAF_ID from
it, then it of course doesn't know that it is a TDX guest. This is the
same thing as the SNP vTom thing: the only viable way going forward is
for the guest kernel to detect correctly what it runs on and act
accordingly.

You can't just do some semi-correct tests for vendor - correct only
if you squint hard enough - and hope that it works because it'll break
apart eventually, when that second-level TDX fun needs to add more
hackery to the guest kernel.

So, instead, think about how the paravisor tells the guest it is running
on one - a special CPUID leaf or an MSR in the AMD case - and use that
to detect it properly.

Everything else is a mess waiting to happen.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

