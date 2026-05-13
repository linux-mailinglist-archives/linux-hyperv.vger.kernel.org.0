Return-Path: <linux-hyperv+bounces-10818-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4LY1JP/0A2rKBAIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10818-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 05:50:23 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD4352D003
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 05:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3F6BF302C3B2
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 03:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC0937BE91;
	Wed, 13 May 2026 03:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t6txehS0"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E2D13C9C4;
	Wed, 13 May 2026 03:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778644046; cv=none; b=lGEBOpN9SCLR9rXuVkfugDfvrThx5oCXiGNOh6Qn8zR571z6j0QsSv6VamjucK/wxwbQ1ws64zHb5nWWWACCU42W4DKyy96r/44RoVv8a9qXjK6m06eWfrk3OijAau1mbEURTo46fo4Y+wpP34lsh4fMruCFCqwTA7DWpAq1pr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778644046; c=relaxed/simple;
	bh=sB0XN6DaT6zUC4dJmgjwjt6U3vW+Dq1Rmj2P+21bPx0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uxesw3VQMOZD4m8WNiz8n+lczeETqZuomgJ++SdZCV8k/rBXdHWvTjbnsNH2efFR5k9OWvkkAHedxk2eXfKAVvTZXzXVS/UvV57Y+KRoMLcT10DayuvS7upz7RswIvxGjYJaq9BwbTSS6FJOb/b1VF5BGbAxi5W9N+WtKPpdDY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t6txehS0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CBDCC2BCC7;
	Wed, 13 May 2026 03:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778644045;
	bh=sB0XN6DaT6zUC4dJmgjwjt6U3vW+Dq1Rmj2P+21bPx0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=t6txehS0LF3Ls2h5BwbS72+A0ovtQC3qPZHZRd7PnkV6LjarYstJAxg14DdVrqkMg
	 +jJYMnF4Tajj8PTwCSv531Rs48Z20G4t9dAZLt9Loi9/uWwDQSzXXhb3lIM4MMowy7
	 u3PYOYgY/6mG/3YWh3dggydSNBsAx5mEcZtQ4BggwQhEDAY2uVp0AJq8Az9tSKQcRU
	 TF3qw6zC3fgWDDoTxXMXcfH7wOfIDLjcdNAd56AdmmU8XDrDWYuABIAArIXSxa9vzo
	 oe2u+pHtVJmmfD8iPvBJqJYFu9qWWfVyOCqCqrR5W7oLovl6XCPeImyVt3Jsi9m/dS
	 AGs0dz8vrq97A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V3 03/11] mshv: Provide a way to get partition ID if
 running in a VMM process
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mukesh R" <mrathor@linux.microsoft.com>
Cc: linux-pci@vger.kernel.org, linux-hyperv@vger.kernel.org
In-Reply-To: <20260512020259.1678627-4-mrathor@linux.microsoft.com>
References: <20260512020259.1678627-4-mrathor@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 03:47:25 +0000
Message-Id: <20260513034725.7CBDCC2BCC7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 8BD4352D003
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-hyperv@vger.kernel.org];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10818-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,sashiko.dev:url,lists.linux.dev:replyto]
X-Rspamd-Action: no action

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Tying VM partition IDs to process TGIDs (`current->tgid`) is an ar=
chitectural flaw causing isolation breakage and security risks.
- [High] `mshv_current_partid()` returns a raw partition ID without taking =
a reference, creating a TOCTOU vulnerability.
- [High] Pre-existing Use-After-Free in `destroy_partition()` due to RCU-00=
1 violation during VP teardown.
--

commit 528e38745b2ae16c0fd8ad4876d893d1b1fea027
Author: Mukesh R <mrathor@linux.microsoft.com>

mshv: Provide a way to get partition ID if running in a VMM process

This commit introduces mshv_current_partid() to allow retrieving the
partition id for the current vmm process. It adds a pt_vmm_tgid field
to the mshv_partition struct and sets it during partition creation.
The partition id is found by iterating the global hash table.

> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index bd1359eb58dd4..02c107458be90 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -1908,6 +1908,27 @@ mshv_partition_release(struct inode *inode, struct=
 file *filp)
>  	return 0;
>  }
> =20
> +/* Given a process tgid, return partition id if it is a VMM process */
> +u64 mshv_current_partid(void)
> +{
> +	struct mshv_partition *pt;
> +	int i;
> +	u64 ret_ptid =3D HV_PARTITION_ID_INVALID;
> +
> +	rcu_read_lock();
> +
> +	hash_for_each_rcu(mshv_root.pt_htable, i, pt, pt_hnode) {
> +		if (pt->pt_vmm_tgid =3D=3D current->tgid) {

Is tying the partition id to the process tgid safe?

Since a single vmm process can create multiple partitions, this loop returns
the first partition matching the tgid. This could result in pci passthrough
operations being misrouted to the wrong partition if a process manages
multiple virtual machines.

Also, since the partition's lifecycle is tied to an anonymous file descript=
or,
passing the fd to another process and exiting would break
mshv_current_partid() for the new process.

Additionally, if the operating system recycles the old tgid, an unrelated
process might gain access to the partition id.

Should explicit file descriptor tracking be used instead of global process
ids?

> +			ret_ptid =3D pt->pt_id;
> +			break;
> +		}
> +	}
> +
> +	rcu_read_unlock();
> +	return ret_ptid;

Does returning a raw partition id without taking a reference create a race
condition?

After rcu_read_unlock() is called and the pt_id is returned, a concurrent
thread in the vmm could close the partition's file descriptor, causing the
partition to be deleted in the hypervisor.

If the hypervisor recycles the pt_id for a newly created partition belonging
to a completely different process, the pending iommu attachment or pci
passthrough hypercall will use the stale pt_id.

Can this allow the vmm to inadvertently attach its devices to an unrelated
partition?

> +}

This isn't a regression in this patch, but looking at the partition lifecyc=
le
code, does destroy_partition() have a use-after-free?

destroy_partition() frees the virtual processor structures (kfree(vp))
before calling remove_partition(partition), which removes the partition
from the rcu-protected global hash table (pt_htable) and calls
synchronize_rcu().

Because the partition remains visible to rcu readers during the teardown lo=
op,
can an interrupt handler (e.g., in mshv_synic.c) call mshv_partition_find(),
successfully retrieve the partition, and read
vp =3D partition->pt_vp_array[vp_index]?

If this happens concurrently with or immediately after kfree(vp), the
interrupt handler would access freed memory.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512020259.1678=
627-1-mrathor@linux.microsoft.com?part=3D3

