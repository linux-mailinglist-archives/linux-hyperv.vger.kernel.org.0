Return-Path: <linux-hyperv+bounces-11863-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YRRPBbYFTmpLBwIAu9opvQ
	(envelope-from <linux-hyperv+bounces-11863-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 08 Jul 2026 10:09:26 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A77722FC5
	for <lists+linux-hyperv@lfdr.de>; Wed, 08 Jul 2026 10:09:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=GTth6Ip2;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11863-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11863-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 37B883011EA2
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Jul 2026 08:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82FB23FE37D;
	Wed,  8 Jul 2026 08:09:15 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F12634D38B
	for <linux-hyperv@vger.kernel.org>; Wed,  8 Jul 2026 08:09:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783498155; cv=none; b=kv2d6tKEcdAaliUXa5q5opTW5Z/zIX49LfXOHs3ofgM2XSIGdtLm1O01Fm3yDhGe1m8I7AvunIxDMu77XaAtj5CuFsr2niAfFxfN87dDTZ3gifbdivqzSg0j/8PYQrPFABn/31Javx6GjGoehrFYZfqQMKbNZTi+QmLlinU8w9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783498155; c=relaxed/simple;
	bh=702mdA8LTCW0LMJY/Wr0rF7VyxkqhvUcebXQgKhzJ40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N4i8c5SzGRSG/nVVz5SJ0UjqOPsCZyHjTbRU8d2smBablNJB5ouLpNnjNZjtdEwpv24D55LjGE+s+Zya23n7AP5wCHU8m4m2l84uc3h2Ddq3NYbtuCuO471bVDxmF7Z4ETq4I0ECPxzIbz35ZA9sdgWIr7/8wVqCxf6XIlbb2vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GTth6Ip2; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783498152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z0t8XVivFCWpKwmYWDQSAZHlhT75KpK6j/oL38Ul+ck=;
	b=GTth6Ip2wQkSqfrSvcpn+br7yNI0Ks0COZF/h2XA9WtJ4ej21HNZiE1FdGDDARMCI9g0g7
	dEpYc0YCGyCs7I26x0ry5kcm+4YXsEFhZ5f7zOe/4aoFurck7kLNOpCCF3Ta3pxNkr2pZz
	vJlkA22J+ywUyvgaJ1lnt8trGBMmhhc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-308-Z38E3Gx0Oo2V3QOF5_1f0Q-1; Wed,
 08 Jul 2026 04:09:09 -0400
X-MC-Unique: Z38E3Gx0Oo2V3QOF5_1f0Q-1
X-Mimecast-MFC-AGG-ID: Z38E3Gx0Oo2V3QOF5_1f0Q_1783498145
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3F8BA1955D5B;
	Wed,  8 Jul 2026 08:09:05 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.49.133])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DB87D1956056;
	Wed,  8 Jul 2026 08:08:58 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: haiyangz@linux.microsoft.com
Cc: linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	ernis@linux.microsoft.com,
	dipayanroy@linux.microsoft.com,
	gargaditya@linux.microsoft.com,
	shradhagupta@linux.microsoft.com,
	linux-kernel@vger.kernel.org,
	paulros@microsoft.com
Subject: Re: [PATCH net-next v2] net: mana: Add handler for sriov configure
Date: Wed,  8 Jul 2026 10:08:54 +0200
Message-ID: <20260708080854.64655-1-pabeni@redhat.com>
In-Reply-To: <20260701180116.507690-1-haiyangz@linux.microsoft.com>
References: <20260701180116.507690-1-haiyangz@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11863-lists,linux-hyperv=lfdr.de];
	FORGED_SENDER(0.00)[pabeni@redhat.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:haiyangz@linux.microsoft.com,m:linux-hyperv@vger.kernel.org,m:netdev@vger.kernel.org,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:ernis@linux.microsoft.com,m:dipayanroy@linux.microsoft.com,m:gargaditya@linux.microsoft.com,m:shradhagupta@linux.microsoft.com,m:linux-kernel@vger.kernel.org,m:paulros@microsoft.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv,netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 98A77722FC5

From: AI Reviewer <ai@example.com>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev/
---
net: mana: Add handler for sriov configure

Add callback function for the pci_driver / sriov_configure.

It asks the NIC to provide certain number of VFs, or disable
VFs if the request is zero.

> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> index e8b7ffb47eb98..f7a79874fd0eb 100644
> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> @@ -2496,6 +2496,20 @@ static void mana_gd_shutdown(struct pci_dev *pdev)
>  	pci_disable_device(pdev);
>  }

[Severity: High]
With the addition of SR-IOV support in this patch, do mana_gd_shutdown() and
mana_gd_remove() need to call pci_disable_sriov()?

If a user enables VFs via sysfs and then unbinds the driver or shuts down the
system, could this omission introduce a regression where orphaned, dead VF PCI
devices are left in the kernel?

Accessing these orphaned VFs might trigger use-after-free crashes or hardware
faults, as the underlying PF hardware and driver context have been destroyed.

> +static int mana_sriov_configure(struct pci_dev *pdev, int numvfs)
> +{
> +	int err = 0;
> +
> +	dev_info(&pdev->dev, "Requested num VFs: %d\n", numvfs);
> +
> +	if (numvfs > 0)
> +		err = pci_enable_sriov(pdev, numvfs);
> +	else
> +		pci_disable_sriov(pdev);

[Severity: High]
Should this path check if the VFs are currently assigned to a guest VM before
disabling SR-IOV?

If a privileged user writes 0 to sriov_numvfs while VFs are actively assigned
to a VM (e.g., via vfio-pci), could forcefully removing the PCI devices cause
a regression resulting in host IOMMU faults and guest kernel panics?

Would it be better to check pci_vfs_assigned(pdev) here, or use the
pci_sriov_configure_simple() helper to safely enforce this?

> +
> +	return err ? err : numvfs;
> +}
-- 
This is an AI-generated review.


