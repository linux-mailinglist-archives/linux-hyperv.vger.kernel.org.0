Return-Path: <linux-hyperv+bounces-11843-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XSbCKLP0S2q0dgEAu9opvQ
	(envelope-from <linux-hyperv+bounces-11843-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Jul 2026 20:32:19 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A58747148A3
	for <lists+linux-hyperv@lfdr.de>; Mon, 06 Jul 2026 20:32:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="UT25/236";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11843-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11843-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A2BF130435FE
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Jul 2026 18:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007D5437864;
	Mon,  6 Jul 2026 18:21:09 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E77C436BFF
	for <linux-hyperv@vger.kernel.org>; Mon,  6 Jul 2026 18:21:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783362068; cv=none; b=Lj8r4c5hq+PmjvnuglCAZyzCrggnQM+kbkLGLK8byMCF9wi/O+1aUvd78NPUJG3HWxISCRp+2KrSFsac1MmWb8vUbhOYlYw9okMunmsrfoQFDhprTVEJOmfWBUtAdoTp9/sPrbQwDs6/0F+EyxMfICkM901lsUBb8o2BKQuaYuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783362068; c=relaxed/simple;
	bh=IwCbm3v2fOe0p8L9vIhHBGDGgMWaYfQAQdVuCHTxUJQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TtqJ2mr+fr+ZX4gjcGR7fuw/LZtms870js/IUX7k1N0OViwTGiroSRejNWTiwLsncFjiQUzZT+Ur0Jy41mPf5edY/uai69qEErt63PPExnjU2HmCw5C33bifrtll5Qz7ySXEVm9NNIKh/2EQkU3S6eWHo5GaNb4/axCHZZKkEtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UT25/236; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A3DD1F000E9;
	Mon,  6 Jul 2026 18:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783362067;
	bh=hH3JGJgz2GkPY4j7m3GWJFsXFPsvJ/vgVtuRUEhbelU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UT25/2364VHGzKILczCGTGmi7+/+4+cCyOadQ7p8byuvZRHAUIQrY5mXol9XYTNY0
	 fpZEAVMzD/bFP8PSh53Q1yVUJ57oiKDAFakqerl0u+2nVdny7oazIHu1EILGOkjV6q
	 qU+jf7aPLln0+yJ/5Y9snTid/34m7/xNxK9SYOfMW1KcKMzlSmjVIpttPEL7l0GULK
	 Rf58gzf3dHirVhlWOZpYArvxsHufa+5Mh4XRTvZvp+F7de3l/WLHvvHwRLZYiRNlJh
	 Fn9GxWKa2MXHz5LUvXBc2Yw0j8/aMn+kBYH2Kz8kxKBCtg154Akx1+561+gKHYjseC
	 Y7ZURHk3OWCQw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 4/4] mshv: Use hmm_range_fault_unlocked() for region
 faults
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stanislav Kinsburskii" <skinsburskii@gmail.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <178336052192.504354.1841795575701703197.stgit@skinsburskii>
References: <178336023903.504354.7500950448226027718.stgit@skinsburskii>
 <178336052192.504354.1841795575701703197.stgit@skinsburskii>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 18:21:05 +0000
Message-Id: <20260706182106.2A3DD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-11843-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:skinsburskii@gmail.com,m:linux-hyperv@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-hyperv@vger.kernel.org];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,smtp.kernel.org:mid,sashiko.dev:url,lists.linux.dev:replyto,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A58747148A3

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing check for fatal signals in retry loop handling HMM faults.
--

commit 4f92a5b1f4b0160351016ede4e0c8d47d308cbfa
Author: Stanislav Kinsburskii <skinsburskii@gmail.com>

mshv: Use hmm_range_fault_unlocked() for region faults

Convert mshv_region_hmm_fault_and_lock() to use hmm_range_fault_unlocked()
instead of taking mmap_read_lock() around hmm_range_fault() directly.
This allows the MSHV fault path to handle mappings whose fault handlers may
drop mmap_lock.

> diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
> index 6d65e5b421529..04676f06c5c74 100644
> --- a/drivers/hv/mshv_regions.c
> +++ b/drivers/hv/mshv_regions.c
> @@ -388,13 +388,11 @@ int mshv_region_get(struct mshv_mem_region *region)
>   *
>   * This function performs the following steps:
>   * 1. Reads the notifier sequence for the HMM range.
> - * 2. Acquires a read lock on the memory map.
> - * 3. Handles HMM faults for the specified range.
> - * 4. Releases the read lock on the memory map.
> - * 5. If successful, locks the memory region mutex.
> - * 6. Verifies if the notifier sequence has changed during the operation.
> + * 2. Handles HMM faults for the specified range.
> + * 3. If successful, locks the memory region mutex.
> + * 4. Verifies if the notifier sequence has changed during the operation.
>   *    If it has, releases the mutex and returns -EBUSY to match with
> - *    hmm_range_fault() return code for repeating.
> + *    hmm_range_fault_unlocked() so the caller retries the range fault.

[Severity: High]
This isn't a bug introduced by this patch, but since we are modifying the
fault retry logic, does the retry loop in mshv_region_range_fault() need to
check for fatal signals?

When mmu_interval_read_retry() detects a collision, this function returns
-EBUSY, which bubbles up to the caller in drivers/hv/mshv_regions.c:

mshv_region_range_fault() {
        ...
        do {
                ret =3D mshv_region_hmm_fault_and_lock(region, &range);
        } while (ret =3D=3D -EBUSY);
        ...
}

If a userspace program continuously invalidates the memory range concurrent=
ly
(for example, via madvise(MADV_DONTNEED)), mmu_interval_read_retry() can
repeatedly return true.

Without a check for fatal_signal_pending(current) inside the loop or before
returning -EBUSY, could this cause the kernel thread to spin indefinitely a=
nd
ignore fatal signals like SIGKILL?

>   *
>   * Return: 0 on success, a negative error code otherwise.
>   */
> @@ -404,9 +402,7 @@ static int mshv_region_hmm_fault_and_lock(struct mshv=
_mem_region *region,
>  	int ret;
> =20
>  	range->notifier_seq =3D mmu_interval_read_begin(range->notifier);
> -	mmap_read_lock(region->mreg_mni.mm);
> -	ret =3D hmm_range_fault(range);
> -	mmap_read_unlock(region->mreg_mni.mm);
> +	ret =3D hmm_range_fault_unlocked(range);
>  	if (ret)
>  		return ret;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178336023903.504354=
.7500950448226027718.stgit@skinsburskii?part=3D4

