Return-Path: <linux-hyperv+bounces-9446-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHysMzhYuGmKcAEAu9opvQ
	(envelope-from <linux-hyperv+bounces-9446-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Mar 2026 20:21:28 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A78E29FC01
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Mar 2026 20:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4350E3151141
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Mar 2026 19:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90CEB3ED5A1;
	Mon, 16 Mar 2026 19:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Fj3Ujr+9"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19012013.outbound.protection.outlook.com [52.103.23.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C615A3ED5A4;
	Mon, 16 Mar 2026 19:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.23.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773688577; cv=fail; b=u1VT2McDzjUR4YGXtxTxl16oKMvRSVUoCoit1vS4NOZde9xda4O7xfpQjpLNYxxhvnFpo2vAKIgNeO/kpD+JC4Kd2qA79yrnbUi7i2NJlZVRap143arT1DbHftm9jj6/YEZIf4c/A/B2CCyVvHSxhPGVKmKacEiLV/UKI3d3gzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773688577; c=relaxed/simple;
	bh=BCgWoEoACPh7LB7hDodyhA7tR9EQIStBblCdrHkzvWM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ARCz32R551+5mje1bicJdAuyvP7xXnIa4oJ1rHYemxxinqdmaBBfZRWMq2S7y2bZFS2qJWFu03Y8Ym6D4/BnnyiQwOQPA1mBMEVdtL+QV0qDEcoTvFMXtgzhAN9Srk9I/4Tn5Nnjfumvkz1je+BZg5o9fS2zzWAj2ia6Q5w2LU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Fj3Ujr+9; arc=fail smtp.client-ip=52.103.23.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m0EEMsToEm1WD96uD5EmBhGvFajcu+um7SnUWPgwwEekyxm4E4t6A+aMAodJ2bGivb+rMq6WDthYsjHJ0hlz/Z7oqDlVFkYMnovip8JuK1cZGm/Dd9PRBleKaSDNaINwhbFrKfD7h2YcsTDeOl1IbAs6iDf5lRxXn5qaebvqJoKfc19SDvdtIrD/3zJ9e5Yk1A9ePrUmSVSsPAm4HeNBH+sd3K3Z3bJodwO0tvaMBH2Y8OqbMqha9xlWb0wuNYn44ErOBPuJU3+Af8e/csrfqcCKQqdje6q4C5DLjsSGLRxSbgKVTptbiuA/g8wjyAEQSbqG9T15Wl1StQlKOg7wTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pg7SbU1dLvWfZBY73eeoYKBF9VjrmOt/9bVGU39LnH4=;
 b=Vea7/uZmRMu6Qcz0vZc/ul4N2/0tJC7rfT66OhZhZ3gVFOCf3FBgnlxAXngyhcpJtuna3/Scw79hRVDAjeiuexstZFn/oZlrD1D5eqdPy5Yiw0vZQHKuUu+Zp7KFrNaN2jRaTQYTHCaqFO2XrZncYkv6rfer8GSbJRkirNucWvtyWpIsTfwIQGmas9jdVD5B7F3Lmev9kPGc1dDiUpkizrAE07k387+y7iNSjn/Gyev+qoJiU88zu9+eMwnT3Udf6JNpD6PAWIrUMSAz7/94CBWaMrVEIBAagPQbYjPqbEOJqpltQVwDtM3bLfKF83VWu+pOEwFxkeVS4zcupAjK1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pg7SbU1dLvWfZBY73eeoYKBF9VjrmOt/9bVGU39LnH4=;
 b=Fj3Ujr+95R/eiBuBeD3IVnn264rQoVHwZ85fzNjx781yT/V/uTx+3BOWqW0eksV5T8i+awdnThpwZkYjRsoq0Vyy5jWarZCzLaG/aa9k+KrXFaXKshPRRxV7DLNIhAzw7OEm5Yp5fS5WKe3bircTLEGXFCb6/mLBN3yKRSQykim7NHW62j9PbAUT1IrFc2CZNsjduAwnmt7mb45e9m+OF99IthXKQVEvJZtulfwfLKD0H6sGYOkkbPvvC0B9XW7rQbDYAMNbnSRuCVtBm4qRDjM8LDQpMFVbZS6vS+lRMWmUmXKrKd8RYmPLkJ08nd3StWbFFuKKmX2Fz50bw1efow==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH0PR02MB8376.namprd02.prod.outlook.com (2603:10b6:510:105::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.22; Mon, 16 Mar
 2026 19:16:04 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9700.024; Mon, 16 Mar 2026
 19:16:03 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Long Li <longli@microsoft.com>, Michael Kelley <mhklinux@outlook.com>, KY
 Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei
 Liu <wei.liu@kernel.org>, Dexuan Cui <DECUI@microsoft.com>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, =?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?=
	<kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Bjorn
 Helgaas <bhelgaas@google.com>
CC: Rob Herring <robh@kernel.org>, Michael Kelley <mikelley@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] PCI: hv: Set default NUMA node to 0 for devices without
 affinity info
Thread-Topic: [PATCH] PCI: hv: Set default NUMA node to 0 for devices without
 affinity info
Thread-Index: AQGzcdRLNO2QZSbCibyDMDhroeyPibYBl7IAgAJcDICAABtAYA==
Date: Mon, 16 Mar 2026 19:16:03 +0000
Message-ID:
 <SN6PR02MB4157BBDC4D3A535D55B7E31BD440A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260312223244.1006305-1-longli@microsoft.com>
 <SN6PR02MB415748A42DCBDD8AB635838DD440A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SA1PR21MB66837DDAF5F203E832DA5339CE40A@SA1PR21MB6683.namprd21.prod.outlook.com>
In-Reply-To:
 <SA1PR21MB66837DDAF5F203E832DA5339CE40A@SA1PR21MB6683.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH0PR02MB8376:EE_
x-ms-office365-filtering-correlation-id: 81721552-ff9b-4d0b-2c9e-08de8390777c
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799015|8062599012|41001999006|19110799012|15080799012|12121999013|461199028|13091999003|37011999003|31061999003|51005399006|3412199025|440099028|102099032|56899033|40105399003|1710799026;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?8cS0WA4DRnlrxRx+/nUB/CzO3JtRswfUDJmZ/8xkNRFMzF8PP9OBOdrlBE?=
 =?iso-8859-2?Q?HEVH74MP8ymvFOZN9O6yHLi3Qkmb1jp7eJLcVuoa2yP4h3mZgHndqJRF5r?=
 =?iso-8859-2?Q?I/BcXTSPqVhJzD4fubP677x4ZM1u6v/dSBpmVCHdoWLZgfwSGUiuwu7DEu?=
 =?iso-8859-2?Q?LBS9KX6h7yYWSI2UDJ2eU5onXtwjKWXlcfeRNql+lNX4HB/XPadJjkirtk?=
 =?iso-8859-2?Q?UuXcSQsBEvsY+tXRl5Vf0ygd35gu3mzgd+h4xWCU3JNAuqUl9B1+zwoaMM?=
 =?iso-8859-2?Q?GkrF1nvyC5K55KewnjBHDEIr6S0AwWWEQC9iZkdZD7aW2XwIu0eUaNZxmP?=
 =?iso-8859-2?Q?GHY6q7BbXJyR37OWu53gXRyJUXpvcALJIhU8dHlhTJ82OB8rrrXHUDYYDG?=
 =?iso-8859-2?Q?bOHNe2zT9Mq8O8J1a1nvSMBmPnJJxhnd27EiOgCbpfp3CollHqTxIZNcO/?=
 =?iso-8859-2?Q?gtqC12yck4qQdCUmqWdgDV6b8HgD1urgOgpUBy2nyFsQ4W+eKrjoQnJwsH?=
 =?iso-8859-2?Q?WShEOzlqst32bviSP/lCi3RaaMJowLaWJYP+7OGJ4DiI1WHBjV5S9yVy0/?=
 =?iso-8859-2?Q?bxbKiOeI6T41HTI+AUxp0RtI4P97O6zk0mGS220jwlWeag6f7AEYTKXdlY?=
 =?iso-8859-2?Q?nIT92xbo4zGoznXb7/UKDSxkw+JFC4g+JhOR6Rbdyy1LCgufmJokFZLk4r?=
 =?iso-8859-2?Q?fQGxT9LcQwHDu2sXJiz3bf6W5hX+kI9EZ2S46GmSTtymSuyAfT0ndvole0?=
 =?iso-8859-2?Q?m/sSEuFhWrJELk0B5dNq+EeVov6EfZhw7diB6afOBXZ89cWmCbZ9atsZVg?=
 =?iso-8859-2?Q?gVI1N5lGfhI9L86y7HQOcyxk9Tej8ac6FEEUAghnlIcPbH2mH42C6tVXXs?=
 =?iso-8859-2?Q?FoRXD/3fvFoUO06OniU77EHGa7RGevhBHqtP6CUkPbTVNkfleHu1Ph6JFr?=
 =?iso-8859-2?Q?E2yXgQV/LGgro3LAiCmOysydI88C9RKqEOsi8EOCLiiK3sRLDCQjfbtW/i?=
 =?iso-8859-2?Q?LDOPYDo0FNrlB3RhQETH2WObPK/sfdd3yhtyoRpQNK02SyD4mpF+7BEQ2L?=
 =?iso-8859-2?Q?xdci8cGXDb9i4JOM9GHQp67KpnRcn73F4IkdhfOVOyZR?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?E4MaWorc0/OHRW2mPz0A2dVfEeiAwMi4PfTxF07FRKuo0Y/GLxCdyzhx0i?=
 =?iso-8859-2?Q?GrK1LgIjmKv3EI5QbVmCOj+EKgdndd6vSiWvJ3xOmzynE28N9JAuDGnnUN?=
 =?iso-8859-2?Q?GW9lcQajoM26LUAfJRg7JA7EQQPBKynRcg1VcksJ1ILiwmye2CYOB3it5C?=
 =?iso-8859-2?Q?puGYy1X/GfOsIHnlFB8v/yWmlEh/mxOslebvYKOWqZYZ5s+XRkm1BP5D6x?=
 =?iso-8859-2?Q?I+NUnfR/68YS5ocLolvMraoYKxztk2ND/6dDzo/77EqsKkCPySerTCDUAg?=
 =?iso-8859-2?Q?dAboaYjx+3zxbMSN7R6obV+P+XFqRQ0Ivug8VTSKuizQoO4Z1WYvufMpI3?=
 =?iso-8859-2?Q?wSG3Nu+AaZzGIt+FRiugZdTguEWmK79xJhJOsCQ2ZTHO94KsAauP5ti+UM?=
 =?iso-8859-2?Q?ibB+zYz3kdYNPrWHJ1A52EzWed5IvdJ4fD8vY/A3qTeQhalYKshxrwGdVe?=
 =?iso-8859-2?Q?FKoe99ENH7bSVYX7id0rZwmFXfPW6uwkBSdajHcUFEQANlhLAGGL0lBlqY?=
 =?iso-8859-2?Q?VgV2noipYqTNLV1kQ0ZlbTVtaKxRZSJN35i84jDRZ8g8eykyUvB+uaIMpU?=
 =?iso-8859-2?Q?g5BfprWoAt2JLfu8MdkDj6Ws+oAl6tWpUxqy8n1aaN+9qj20npG71xTwed?=
 =?iso-8859-2?Q?nSfRvG56Z2uqkJfD8XgrMp9CzmmuJedNYktgO6IoiYzR3MCtQ9aCi7tW4Z?=
 =?iso-8859-2?Q?2UZ07UBDVr4txIjMwvMefTL+Trp+0m1K3gdr7WKm04ah2ffRAvA7HfUjKF?=
 =?iso-8859-2?Q?SLhEWb5gBV5X5PXq2Q9ppTNKe4hgYXbxFNHGjX7/LmnO/PN4F+hplyOP+1?=
 =?iso-8859-2?Q?UyJQMMIAmaqsD2ky6MUReCHv9IeeiAyI9WRuA7V11SPX71zTlwhBeTw7my?=
 =?iso-8859-2?Q?M+LEpL/PejvDRQSWAAGYZbb38Ud6Wqe5H5jn47VhcoY4fWLjOMcC/Gi3e2?=
 =?iso-8859-2?Q?GWgamoRbVRwXi8wuTEnFkvzuFvKYDuS5nJ+vbgcW/EKYeKjhVgCRBV6umH?=
 =?iso-8859-2?Q?uEeeHQoQLCNmlM/NqIfwX4HIUwx7QglSXdzECwH57XEV6oNDlYOPZvBld+?=
 =?iso-8859-2?Q?tcuyg419gH7dZ5P38s0LLka9X5Pm4DqvrrPmeq3hFF3vFpxCrNeXdch62E?=
 =?iso-8859-2?Q?eJ8S6VxWDs3PE7Bejlg2gCfpKD8bt3XxK5Mgr3nT+prPF6vWYGkkB5Wh+6?=
 =?iso-8859-2?Q?nGoUruhBo+Nyf55fbGFWRNyOfBn2h+n8JODSLeP+OxeBtBhHedJOXX+W8q?=
 =?iso-8859-2?Q?5kXx3If1wSgFUIYIgURmJsm+CZNK3yarL+U7NydkKxdddYNnfUN2hQYtiJ?=
 =?iso-8859-2?Q?gP0jlMfo1UdpZB6or83WAXKw5WS65TtxOEFs8SI5WBNjRxkzL7kfBLmtwh?=
 =?iso-8859-2?Q?6zsADTzAFMr+3aqqILCDNaP8l3PP85Pok92jPsS3oKdIbFVgsfq+8=3D?=
Content-Type: text/plain; charset="iso-8859-2"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 81721552-ff9b-4d0b-2c9e-08de8390777c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2026 19:16:03.6162
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8376
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9446-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	FREEMAIL_TO(0.00)[microsoft.com,outlook.com,kernel.org,google.com];
	RCPT_COUNT_TWELVE(0.00)[15];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[SN6PR02MB4157.namprd02.prod.outlook.com:mid,outlook.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7A78E29FC01
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Long Li <longli@microsoft.com> Sent: Monday, March 16, 2026 10:38 AM
>=20
> > Subject: [EXTERNAL] RE: [PATCH] PCI: hv: Set default NUMA node to 0 for=
 devices
> > without affinity info
> >
> > From: Long Li <longli@microsoft.com> Sent: Thursday, March 12, 2026 3:3=
3 PM
> > >
> > > When a Hyper-V PCI device does not have
> > > HV_PCI_DEVICE_FLAG_NUMA_AFFINITY set or has an out-of-range
> > > virtual_numa_node, hv_pci_assign_numa_node() leaves the device NUMA
> > > node unset. On x86_64, the default NUMA node happens to be 0, but on
> > > ARM64 it is NUMA_NO_NODE (-1), leading to inconsistent behavior acros=
s
> > > architectures.
> > >
> > > In Azure, when no NUMA information is available from the host, device=
s
> > > perform best when assigned to node 0. Set the device NUMA node to 0
> > > unconditionally before the conditional NUMA affinity check, so that
> > > devices always get a valid default and behavior is consistent on both
> > > x86_64 and ARM64.
> >
> > I'm wondering if this is the right overall approach to the inconsistenc=
y.
> > Arguably, the arm64 value of NUMA_NO_NODE is more correct when the Hype=
r-
> > V host has not provided any NUMA information to the guest. Maybe the x8=
6/x64
> > side should be changed to default to NUMA_NO_NODE when there's no NUMA
> > information provided.
>=20
> Tests have shown when Azure doesn't provide NUMA information for a PCI de=
vice,
> workloads runs best when the node defaults to 0. NUMA_NO_NODE results in
> performance degradation on ARM64. This affects most high-performance devi=
ces like
> MANA when tested to line limit.
>=20
> >
> > The observed x86/x64 default of NUMA node 0 does not come from x86/x64
> > architecture specific PCI code. It's a Hyper-V specific behavior due to=
 how
> > hv_pci_probe() allocates the struct hv_pcibus_device, with its embedded=
 struct
> > pci_sysdata. That struct pci_sysdata has a "node" field that the x86/x6=
4
> > __pcibus_to_node() function accesses when called from pci_device_add().
> > If hv_pci_probe() were to initialize that "node" field to NUMA_NO_NODE =
at the
> > same time that it sets the "domain" field, x86/x64 guests on Hyper-V wo=
uld see
> > the PCI device NUMA node default to NUMA_NO_NODE like on arm64. The
> > current behavior of letting the sysdata "node" field stay zero as alloc=
ated might
> > just be an historical oversight that no one noticed.
>=20
> I agree this was an oversight in the original X64 code, in that it sets t=
o numa node 0 by
> chance. But it turns out to be the ideal node configuration for Azure whe=
n affinity
> information is not available through the vPCI. (i.e. non isolated VM size=
s). This results in
> X64 perform better than ARM64 on multiple NUMA non-isolated VM sizes.
>=20
> >
> > Are there any observed problems on arm64 with the default being
> > NUMA_NO_NODE? If there are such problems, they should be fixed separate=
ly
> > since that case needs to work for a kernel built with CONFIG_NUMA=3Dn.
> > pcibus_to_node() will return NUMA_NO_NODE, making the default on x86/x6=
4
> > be NUMA_NO_NODE as well.
> >
> > I've tested setting sysdata->node to NUMA_NO_NODE in hv_pci_probe(), an=
d
> > didn't see any obviously problems in an x86/x64 Azure VM with a MANA VF=
 and
> > multiple NVMe pass-thru devices. The NUMA node reported in /sys for the=
se PCI
> > devices is indeed NUMA_NO_NODE.
> > But maybe there's some other issue that I'm not aware of.
>=20
> Extensive tests have shown defaulting NUMA node to 0 preserved the existi=
ng behavior
> on X64, while improving performance on ARM64, especially for MANA. This h=
as been
> confirmed by the Hyper-V team, and Windows VM uses the same values for de=
faults.

Ah, OK.  That makes sense.  I'd suggest doing a new version of the patch wi=
th
the commit message and the code comment describing performance as the
main reason for the patch.  You somewhat said that in your current commit
message, but it got muddled with the compatibility discussion, and the code
comment just mentions compatibility. Compatibility between x86/x64 and
arm64 isn't really the issue. The idea is that hv_pci_assign_numa_node() sh=
ould
always set the NUMA node to something, rather than depending on the default=
,
which might be NUMA_NO_NODE. If the Hyper-V host provides a NUMA node,
use that. But if not, use node 0 because that is usually where the underlyi=
ng
hardware actually has the physical device attached. Node 0 might not be
right in certain situations, but if Hyper-V doesn't provide more informatio=
n
to the guest, guessing node 0 is better than letting the Linux kernel do
something like load balancing across NUMA nodes, which could happen
with NUMA_NO_NODE.  (At least, that's what I think happens!)

Michael

>=20
> Thanks,
>=20
> Long
>=20
> >
> > Michael
> >
> > >
> > > Fixes: 999dd956d838 ("PCI: hv: Add support for protocol 1.3 and suppo=
rt PCI_BUS_RELATIONS2")
> > > Signed-off-by: Long Li <longli@microsoft.com>
> > > ---
> > >  drivers/pci/controller/pci-hyperv.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/drivers/pci/controller/pci-hyperv.c
> > > b/drivers/pci/controller/pci-hyperv.c
> > > index 2c7a406b4ba8..5c03b6e4cdab 100644
> > > --- a/drivers/pci/controller/pci-hyperv.c
> > > +++ b/drivers/pci/controller/pci-hyperv.c
> > > @@ -2485,6 +2485,9 @@ static void hv_pci_assign_numa_node(struct hv_p=
cibus_device *hbus)
> > >  		if (!hv_dev)
> > >  			continue;
> > >
> > > +		/* Default to node 0 for consistent behavior across architectures =
*/
> > > +		set_dev_node(&dev->dev, 0);
> > > +
> > >  		if (hv_dev->desc.flags & HV_PCI_DEVICE_FLAG_NUMA_AFFINITY &&
> > >  		    hv_dev->desc.virtual_numa_node < num_possible_nodes())
> > >  			/*
> > > --
> > > 2.43.0
> > >
>=20


