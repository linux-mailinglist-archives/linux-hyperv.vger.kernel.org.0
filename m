Return-Path: <linux-hyperv+bounces-11020-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIwkHxn4C2o3SgUAu9opvQ
	(envelope-from <linux-hyperv+bounces-11020-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 May 2026 07:41:45 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B809577814
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 May 2026 07:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E208E302E7E5
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 May 2026 05:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADBF7342CBA;
	Tue, 19 May 2026 05:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="QBHBXOX7"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF4033F5B1;
	Tue, 19 May 2026 05:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779169301; cv=none; b=gccSR8RCsc8jv8niYQkP1AGnAAZxfoSFhu9VjsEjA7cauhp3YDsGd5Ka6Asyz0gm7vClrIpLPda1Z9RI6uC4yDmWhc4y5lVyls1lGg+Rge4jTJFsvJ8T9aQQ95Rzk6sapDTTSwEiVZlQyGVXdddKou3C4MRi7Y8i9nhNscq/SzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779169301; c=relaxed/simple;
	bh=o/yS0uOYS4L22n6+JUVWldOroJpthMRMLg3OceU4NKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JgQv6xXT2AleoXDST26oz7qakMU62qy5S/iYAGKIv9xuuqJS90PVWZY7X2Gx4WGuoklIdZUXO/+Pqd0fkMK1jlWCgGZSYSoza6azWtYNq1ruwEkYLDHlP/diGvNPyQk/RlQQ+7lQqeo/qvq5PyPMZUy9cPl6fflOpIXmVYOK1jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=QBHBXOX7; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from localhost (unknown [20.236.10.129])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0A10320B7166;
	Mon, 18 May 2026 22:41:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0A10320B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779169293;
	bh=9aRpORwCZcDZFRWxP8HU9OITjEdjOoC0GPbZGiL6PAE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QBHBXOX7NdP4TdXu30LQKuB2NYOv84+TiJbyOMei9/B5p2NONJonvvHwp8+UGl7Di
	 xGY46GW2lgvUSxky3V6/VCwTuYnggPWiGgKUQD9n1qKLoY7She5JEnC9buZni3H2Cc
	 bHezQ7XDvQcwggOxNVSG9QFaENzjE6xuHjR66ZHI=
Date: Mon, 18 May 2026 22:41:36 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Mukesh R <mrathor@linux.microsoft.com>, hpa@zytor.com,
 robin.murphy@arm.com, robh@kernel.org, wei.liu@kernel.org,
 mhklinux@outlook.com, muislam@microsoft.com, namjain@linux.microsoft.com,
 magnuskulke@linux.microsoft.com, anbelski@linux.microsoft.com,
 linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
 iommu@lists.linux.dev, linux-pci@vger.kernel.org,
 linux-arch@vger.kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
 decui@microsoft.com, longli@microsoft.com, tglx@kernel.org,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
 x86@kernel.org, joro@8bytes.org, will@kernel.org, lpieralisi@kernel.org,
 kwilczynski@kernel.org, bhelgaas@google.com, arnd@arndb.de,
 jacob.pan@linux.microsoft.com
Subject: Re: [PATCH V3 09/11] x86/hyperv: Implement Hyper-V virtual IOMMU
Message-ID: <20260518224136.0000403e@linux.microsoft.com>
In-Reply-To: <20260515182322.GI7702@ziepe.ca>
References: <20260512020259.1678627-1-mrathor@linux.microsoft.com>
	<20260512020259.1678627-10-mrathor@linux.microsoft.com>
	<20260515182322.GI7702@ziepe.ca>
Organization: LSG
X-Mailer: Claws Mail 3.21.0 (GTK+ 2.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11020-lists,linux-hyperv=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_CC(0.00)[linux.microsoft.com,zytor.com,arm.com,kernel.org,outlook.com,microsoft.com,vger.kernel.org,lists.linux.dev,redhat.com,alien8.de,linux.intel.com,8bytes.org,google.com,arndb.de];
	RCPT_COUNT_TWELVE(0.00)[32];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.pan@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:mid,linux.microsoft.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,ziepe.ca:email]
X-Rspamd-Queue-Id: 0B809577814
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Jason,

On Fri, 15 May 2026 15:23:22 -0300
Jason Gunthorpe <jgg@ziepe.ca> wrote:

> On Mon, May 11, 2026 at 07:02:57PM -0700, Mukesh R wrote:
> > +static struct iommu_domain *hv_iommu_domain_alloc_paging(struct
> > device *dev) +{
> > +	struct hv_domain *hvdom;
> > +	int rc;
> > +
> > +	if (hv_l1vh_partition() && !hv_curr_thread_is_vmm()) {
> > +		pr_err("Hyper-V: l1vh iommu does not support host
> > devices\n");
> > +		return NULL;
> > +	}
> > +
> > +	hvdom =3D kzalloc(sizeof(struct hv_domain), GFP_KERNEL);
> > +	if (hvdom =3D=3D NULL)
> > +		return NULL;
> > +
> > +	spin_lock_init(&hvdom->mappings_lock);
> > +	hvdom->mappings_tree =3D RB_ROOT_CACHED;
> > +
> > +	/* Called under iommu group mutex, so single threaded */
> > +	if (++unique_id =3D=3D HV_DEVICE_DOMAIN_ID_S2_NULL)   /* ie,
> > UINTMAX */
> > +		goto out_err;
> > +
> > +	hvdom->domid_num =3D unique_id;
> > +	hvdom->partid =3D hv_get_current_partid();
> > +	hvdom->iommu_dom.geometry =3D default_geometry;
> > +	hvdom->iommu_dom.pgsize_bitmap =3D HV_IOMMU_PGSIZES;
> > +
> > +	/* For guests, by default we do direct attaches, so no
> > domain in hyp */
> > +	if (hv_dom_owner_is_vmm(hvdom) && !hv_no_attdev)
> > +		hvdom->attached_dom =3D true; =20
>=20
> What are you thinking sending something like this?!?!?
>=20
> The function is called *alloc domain PAGING*, it does not, and can not
> allocate weird "special" domains that are not PAGING domains. I just
> spent a long time removing all this kind of crazyness from drivers.
>=20
> There is alot of other things I don't like in this patch, but this is
> too much.
>=20
> You have to drop this "direct attach" idea from the first iteration,
> Linux can't do it without alot more work, you should start with the
> basic paging domain mode.
>=20
Just wondering what work is needed to support this "direct attach"? I
felt this issue is due to trying to cram two distinct domain types
(paging domain & direct attach) into the VFIO container model where
only unmanaged paging domain is supported.

I am thinking if we were to switch to iommufd and let user(vmm) have
direct control of HWPT, vmm will be able to selectively use a
different domain type to handle direct attach. IMHO, it is essentially
the same as attaching nest parent domain without nested domain
immediately attached. The unprivileged guest may attach nested domain
directly with Hyper-V if nested translation is needed.

I understand nest parent is still a paging domain today and it is
expected to work with nested domain. So maybe we can make iommufd
accept nest parent w/o paging? i.e. no map/unmap and do not call
iopt_table_add_domain()? or maybe a new object?

=46rom this driver POV, it will allocate a 2nd stage only domain with
different domain ops (w/o map/unmap) for "direct attach" thus avoid this
hack.

Thanks,

Jacob

