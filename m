Return-Path: <linux-hyperv+bounces-10891-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGWAC807BmqmggIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10891-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 14 May 2026 23:17:01 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B96A546F74
	for <lists+linux-hyperv@lfdr.de>; Thu, 14 May 2026 23:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D15AD3014841
	for <lists+linux-hyperv@lfdr.de>; Thu, 14 May 2026 21:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD20C3A452A;
	Thu, 14 May 2026 21:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Iif26zqM"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19012008.outbound.protection.outlook.com [52.103.14.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601D831E852;
	Thu, 14 May 2026 21:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778793414; cv=fail; b=X1kHjh0mapqA0VZMbj2DHtTF2b2fhIUcrYu+q/maeC+3/TR24M8YKu1UGz9Cf6yugxAhNMESd1B8icoz6W8prtxEkTK0meTmwfjCZ0lBrlXXVKRsFndq/HzrfSZ83xw9ebQv/2heMACiQLVDpPHBV6EY8nfKJC1WL+b7jaHp7Sc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778793414; c=relaxed/simple;
	bh=PPjtarZpqsf+gCNleg2qE1rYicVaE1216tL/6URFdk0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m+DKU1Rt+vNcnzrmhcv/Xif9wM8KinPl6L92VCSXIV4eeGpkM1bomfQfgJkW3Rk7J9qqsK3fjJYx4sVDK8w3DaRZC9IicTrtSJyFuAtNX7dFBmtX7CCBKPX2u6KVRITZLipZL5ooAbv33pQqdDwgwR/SaaKOcE9GjfM/W1cZdSU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Iif26zqM; arc=fail smtp.client-ip=52.103.14.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pWlDuxLllShdJYPMKpOMGmLeuP0eF46AU53JtNxdbO2DUrDt2UyczPuBRQXDuJ6S85J1D1nRJtngn9Pn8w/Mbtj9Dtr1s+DyDnnITNEGqaGj7Qeb5CFaQdHlCeG+fCtAr9iP0HjouhVLHEgBiCBpOf00SMBRHBJUTmV1dKglKjim8GOn7A1++QjZbU/o4SaEGZTg/zVSiVH//blbf4X2aEbXyPsIzBRDkvMZMfrgh/H3cZNHj5o85iQeOu8HnFWCV17Y1qfvSfEz1f0Ph4Z2nnPS8NL4wxax5+Z2gegzdjwLIqvsADofLgNT4TTxKfTzEgQcowEndZiZkE3xw/6oKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Of4VgdDIsd7+hdivoS3qzYRXgFfM9+iAy6Zw1wZ8GY=;
 b=ARSUH2e0tdbWoxlkcrAAeWSFycjtL5VVJPodvra2Zk0jNo59TAW5GS6LqSDuwj1QRxkCx6fkfBSVXco008a9a6ir9ND+4DN4qwcr/azl0bN0Qu66imhlqC20NgBTnWMDuMweoi6nh7QGoUp+a4ABRqwqyvyIuXqjh4sHSvjVwocp3YXLPQYYBhu8WxismebJW2lhjAs8fYePLBukwpP8p2A6tgadVVH7IvWcnf0awkfk9n6sksRBO/iJ9GeGOWz1hCItLpTfpyby4R0pXK85iUsnLFqbaoS/fsmVg0E+VjwgPXkx9u3qKbB8GHm4CVRQ6o5sqiGRT86tJ/rqW8+eFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Of4VgdDIsd7+hdivoS3qzYRXgFfM9+iAy6Zw1wZ8GY=;
 b=Iif26zqMBMcASGc+hAq8Q11c7DVm9PEYeMVNQ5x9u3mRlgzostPxXjP/zOvf8y9xk4+mW5v/pEz5kiBv9yzCyKq8JM/w4dTokar46+uMYMu7ZsdPhuR5ql2NJrXpaHONx5XpVnf/E6sbOjFqNABmKrdgWgO8yQ6NLC10mB7KRCGmZYT3iUvZHY7JriZ8O/NbrAx+Uf+e932KVZmw1ccG49PUwiZor4f5BabcOIGPMrVkSZXWpyOZTp7T4nqfuaqv8ueWjdTuspU1l6W53v1Q+eejVAx61CrYHoAHh+FGWyp6USj2fVyc82XFmGpDZoj8I24XyvZNkGVVwKLXSFoKwg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH0PR02MB7751.namprd02.prod.outlook.com (2603:10b6:510:51::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 14 May
 2026 21:16:50 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9913.009; Thu, 14 May 2026
 21:16:49 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Michael Kelley <mhklinux@outlook.com>, Yu Zhang
	<zhangyu1@linux.microsoft.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>
CC: "wei.liu@kernel.org" <wei.liu@kernel.org>, "kys@microsoft.com"
	<kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"decui@microsoft.com" <decui@microsoft.com>, "longli@microsoft.com"
	<longli@microsoft.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "mani@kernel.org" <mani@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>, "jacob.pan@linux.microsoft.com"
	<jacob.pan@linux.microsoft.com>, "tgopinath@linux.microsoft.com"
	<tgopinath@linux.microsoft.com>, "easwar.hariharan@linux.microsoft.com"
	<easwar.hariharan@linux.microsoft.com>
Subject: RE: [PATCH v1 4/4] iommu/hyperv: Add page-selective IOTLB flush
 support
Thread-Topic: [PATCH v1 4/4] iommu/hyperv: Add page-selective IOTLB flush
 support
Thread-Index: AQHc4WKquRiuLrUu+ESNYKKX1F+8PLYN2DNAgAAy8ZA=
Date: Thu, 14 May 2026 21:16:49 +0000
Message-ID:
 <SN6PR02MB41574251063C91003E97890ED4072@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260511162408.1180069-1-zhangyu1@linux.microsoft.com>
 <20260511162408.1180069-5-zhangyu1@linux.microsoft.com>
 <SN6PR02MB41577D5EEC884EAE8AF5E14ED4072@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To:
 <SN6PR02MB41577D5EEC884EAE8AF5E14ED4072@SN6PR02MB4157.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH0PR02MB7751:EE_
x-ms-office365-filtering-correlation-id: eb5eef9b-afd9-45a2-f50c-08deb1fe1ce2
x-microsoft-antispam:
 BCL:0;ARA:14566002|55001999006|19101099003|15080799012|41001999006|37011999003|51005399006|31061999003|8060799015|8062599012|13091999003|19110799012|40105399003|3412199025|440099028|102099032|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?2CcISJmUcasvLa8+frAZcQAUg9sNPOl7tDSkjnTiheeNbc+vl6BJM/nzgCPh?=
 =?us-ascii?Q?LtJCQ51yngcP+JcD+Bx7pPa1qEOWUC/mbVGXOdGEDoiz0BYfh9fqspJypaBn?=
 =?us-ascii?Q?Hd7f0nT7r67MLMFrKrpYhObqvsXv9Dq6pDYYFdDw4xhZSIRoQ98IA2FeDKvi?=
 =?us-ascii?Q?qQtRN/DWfUUqYYi3vQklGrmAutH6m1sDfcDWuAgcBFqDDTML/9+4dcuqF0PJ?=
 =?us-ascii?Q?kzCMOjRhXmHRdy8ao4WsrAQ4EOP6Qq1l2UTpGZwFNklvPS4G6Fl3gsTPz+sg?=
 =?us-ascii?Q?xTJZYmB8oOt40bRXbea0NJIwtxulXEmkdiDvWQgpNHsXUN081xOnc7edUXW8?=
 =?us-ascii?Q?h9JGsdgm1mECs9/t9oWk6I16wxFnNmB+0Y8a0Io+OPgmT0MVLr43ntdhg0O2?=
 =?us-ascii?Q?AUDYKr9uckxHf9lws6iZydeA8RaxtKi9wVGtsdWfUvDds/2plTOpdjqXTCvg?=
 =?us-ascii?Q?vZmVxwKxzDcKSzcp0VbMID/uJXZYDmdutPJkW8Ov7q0KbrMuTWhXBYsp0o6d?=
 =?us-ascii?Q?C8pgEHsS6siH4vqs6KGzRcmUTmCs882T4+ToUwRPblVLI+y3/uHGR37ieZD9?=
 =?us-ascii?Q?bWLV/3tGs2jAuYP8dfglfnPP971LCZ0jvSn2z+aMbMCqZYZzdcchTtaO9qFb?=
 =?us-ascii?Q?gw+0lE8Z7ys4Jwpal3idlL7AFPXnEFKrZMhtp/2BDJbRJ3t8lz/L355SWeY+?=
 =?us-ascii?Q?XGoyH9ZIn9x0YFypdKyAQ9NI5QZkgBZUm+hecgReGW6aqQB7Rc8mxhhIs16s?=
 =?us-ascii?Q?hyXm8W/NWx9iBNs/iyzJuVgxlWZjTnCVcJN1MofTAEpcf/GleYK+iC/JIIpi?=
 =?us-ascii?Q?ZN890lzBeuZkpIn8ePU/JguqPnp3YqJrAyl4HV/wEY/5DJCIf7yPlRUArsH6?=
 =?us-ascii?Q?rIKH4rfQ2jDowN2Pcqq4/HjH6rftUw041KDfTRC9ExzjEjHhiXhmaXHQPQGL?=
 =?us-ascii?Q?2XPW5HdcB8EuUwg5s/jn7fJmW5oWMYStt6y30a1ExysYuVX1II/L2wnsSSkK?=
 =?us-ascii?Q?swfduHi0IyZW2n5lRDvsk/hw7d1v13LO4mRqPaz/XEIDGpppZiCIxtdAq/Zc?=
 =?us-ascii?Q?vugNtybYUEmCQ2YE1ci/ssGXLIRjtcw34PUN3XfC3ZNSFrY/hBY=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?d9GuMw9S5iAnEAVV5Ghsafsutc0Y4BmTB/TBX50NkHZwSnpTdGOyMirvKO98?=
 =?us-ascii?Q?g+zpYx9qdkzF35u1V/PgspG+/mG/e2Ybr8Ybtlwc1zM9FchYKe4V/0DEkiZ7?=
 =?us-ascii?Q?/hPWN5TtqanlwPokADxTs7hpaQNBkdA8hfirO2/52QcHovkRxL5lwFwqLqlD?=
 =?us-ascii?Q?JMdS865RbIyicvuIrfZDzwd3al45yLxHbvUeSz82cuFkWHb4FCktWVXc7zMh?=
 =?us-ascii?Q?BSGINy+/EOpKLjEomxQsGpxbbUXbkAeeJH3lrtnnZQE+WI62/YltI7PFHMC2?=
 =?us-ascii?Q?zkIMNMa8mGeE/GP82P2/mOg650UUrRvJrDCnm2ArHw8uyfVPJcG2N6masWQv?=
 =?us-ascii?Q?9Ggah7y9LIxcG2XqJ19Ijgwu5ZZ950uaf4hfvlhdoYZ9gzNED7HPokPlA1aB?=
 =?us-ascii?Q?BdabyallAKSCDqae5ZM5Qq8zXhUta8x2Y76t719CKXO9fjZq5cJtvPxRkSAp?=
 =?us-ascii?Q?ZDlsc5M5grvPLWRT0d4j0XRSWee4kKyjcFYJ1xGs0I1w727upAHZ5jlHCXez?=
 =?us-ascii?Q?cumW6XjKXyUZTXnHuG9l+YMCvnC1Vkxb6cCXfrTVz1JApLI0DkXnnKmKk/+a?=
 =?us-ascii?Q?+bM0JWUrCB/p3VIJBb8hzXd/gxIiVtds50XdfbeUFDjofQbutVX68s0/Z2+k?=
 =?us-ascii?Q?hwX1lQiroKQdkM3Vb0DYRHzfB2APRK/rWVEcPLXJZl3Wx8uhKg5Vvmvv93KS?=
 =?us-ascii?Q?94Y2mpduLiCAvMWr1wfkuEchyxbHZ1PbZXOVMNf3vNyb2f8GXaA4WdMp+fY5?=
 =?us-ascii?Q?Gz4By5jnYApyKNJF2Sm9YVgwEAE7+fK9Z3Q/k/A8j57I4w8/CTxaZcIamu5f?=
 =?us-ascii?Q?844CCw5S5tTrVWpVqxXbHLkYh+5CZ/hBbiEdkDRdP2ibU/cBmIt9+GqQ6iKo?=
 =?us-ascii?Q?KW3ACgS2LBa/MH9zoqUUvw4DmfQ1G6OW8BlTrRUXiGwhneAW5HAwnuZ8ly1r?=
 =?us-ascii?Q?9ChDGKnT+FaZOUeIgyX3v8aW8Zzx5ahsDHVax23JSJsrl2X96RnfgX2q2A8y?=
 =?us-ascii?Q?k7cy+vo0HE55MYg/5yxMf4ZV+IGG+5FlmhcOWFk5vcy+HmRYy1xlcs69JkL7?=
 =?us-ascii?Q?HoBna0+Yir/KpeMORq9286wYrnlVj+oyR9jvjXX9FqLW3gigBAGpIZjRrrHk?=
 =?us-ascii?Q?HXNihhQWSeB2mmPaLaijVpguqzFQ+xOsMKSJDfPkLvzijbAI0dT+CQiWHI7h?=
 =?us-ascii?Q?rg94Phh0wKfe5jimpi089yzEDxM67/a0VhzOQwBPmBDbaX8lDgWqdPcq8AMI?=
 =?us-ascii?Q?H6HSziyE1R6J7LfccWJuNu1v2byImrT8/qOBmAIJlHQ9J2Crcm/DQVK9dOGK?=
 =?us-ascii?Q?x2Yy4ezTF2vlTXsPHtap6sosT53q6ztoOW71GHObFhGnS1HQ8vsR7NCtC+e9?=
 =?us-ascii?Q?Q6hlWJg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: eb5eef9b-afd9-45a2-f50c-08deb1fe1ce2
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2026 21:16:49.7542
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7751
X-Rspamd-Queue-Id: 3B96A546F74
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10891-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	FREEMAIL_TO(0.00)[outlook.com,linux.microsoft.com,vger.kernel.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[outlook.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhklinux@outlook.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,outlook.com:email,outlook.com:dkim]
X-Rspamd-Action: no action

From: Michael Kelley <mhklinux@outlook.com> Sent: Thursday, May 14, 2026 11=
:14 AM
>=20
> From: Yu Zhang <zhangyu1@linux.microsoft.com> Sent: Monday, May 11, 2026 =
9:24 AM
> >
> > Add page-selective IOTLB flush using HVCALL_FLUSH_DEVICE_DOMAIN_LIST.
> > This hypercall accepts a list of (page_number, page_mask_shift) entries=
,
> > enabling finer-grained IOTLB invalidation compared to the domain-wide
> > HVCALL_FLUSH_DEVICE_DOMAIN used by hv_iommu_flush_iotlb_all().
> >
> > hv_iommu_fill_iova_list() decomposes a contiguous IOVA range into a
> > minimal set of aligned power-of-two regions that fit in a single
> > hypercall input page. When the range exceeds the page capacity, the
> > code falls back to a full domain flush automatically.
> >
> > Signed-off-by: Yu Zhang <zhangyu1@linux.microsoft.com>
> > Signed-off-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> > ---
> >  drivers/iommu/hyperv/iommu.c | 91 +++++++++++++++++++++++++++++++++++-
> >  include/hyperv/hvgdk_mini.h  |  1 +
> >  include/hyperv/hvhdk_mini.h  | 17 +++++++
> >  3 files changed, 108 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/iommu/hyperv/iommu.c b/drivers/iommu/hyperv/iommu.=
c
> > index e5fc625314b5..3bca362b7815 100644
> > --- a/drivers/iommu/hyperv/iommu.c
> > +++ b/drivers/iommu/hyperv/iommu.c
> > @@ -486,10 +486,98 @@ static void hv_iommu_flush_iotlb_all(struct iommu=
_domain *domain)
> >  	hv_flush_device_domain(to_hv_iommu_domain(domain));
> >  }
> >
> > +/* Max number of iova_list entries in a single hypercall input page. *=
/
> > +#define HV_IOMMU_MAX_FLUSH_VA_COUNT \
> > +	((HV_HYP_PAGE_SIZE - sizeof(struct hv_input_flush_device_domain_list)=
) / \
> > +	 sizeof(union hv_iommu_flush_va))
> > +
> > +/* Returned by hv_iommu_fill_iova_list() when the range exceeds the ca=
pacity */
> > +#define HV_IOMMU_FLUSH_VA_OVERFLOW	U16_MAX
> > +
> > +static inline u16 hv_iommu_fill_iova_list(union hv_iommu_flush_va *iov=
a_list,
> > +					  unsigned long start,
> > +					  unsigned long end)
> > +{
> > +	unsigned long start_pfn =3D start >> PAGE_SHIFT;
> > +	unsigned long end_pfn =3D PAGE_ALIGN(end) >> PAGE_SHIFT;
>=20
> "end" is an inclusive end address per comment in struct iommu_iotlb_gathe=
r.
> So a page aligned value would typically have 0xFFF as the low order 12 bi=
ts,
> and PAGE_ALIGN() will do the right thing. But I don't think the value is
> *required* to be page aligned.  If the value of "end" had 0x000 as the
> low order 12 bits, the above calculation would fail to include the page
> that has the address ending in 0x000.  I think it needs to be
> PAGE_ALIGN(end + 1) in order to work correctly for this corner case.
>=20

One follow-on comment:  the macros HVPFN_UP() and HVPFN_DOWN()
would likely be useful in setting start_pfn and end_pfn.

Michael

