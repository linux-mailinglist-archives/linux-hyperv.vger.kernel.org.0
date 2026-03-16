Return-Path: <linux-hyperv+bounces-9445-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KI0vEYNAuGnSawEAu9opvQ
	(envelope-from <linux-hyperv+bounces-9445-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Mar 2026 18:40:19 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4115229E6B2
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Mar 2026 18:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EA002301BD48
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Mar 2026 17:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8847420ED;
	Mon, 16 Mar 2026 17:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="DeyYstSw"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11021098.outbound.protection.outlook.com [40.107.208.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2326D2E401;
	Mon, 16 Mar 2026 17:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773682719; cv=fail; b=mI17J4wl5NBVZV9lztDWoaIsqVEq/Pb3S44+meEKomavDKzdeUX2OPnaa4S1C/s0Ynkt0MF7hwFBa8opMD8nZ+qpDFt5CjAbuBJhPmPJDb44Ji3gdIb7M0ovs5zKJbSm3KSw/Ig5G2zIPFZW4pwJ7pIyvqZMl8Ga41DlHY6KFAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773682719; c=relaxed/simple;
	bh=m+SOKFoKj8NzveyIy8tq29BM4aan+/JtR+9d54Aaj7s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=antCGIanxXJMLtMB8tIjLKp8BNeVrgb6/J0LjDPOFyqktD0UL1SQ63q22+4a9jVfKlbYqEG1FX9C03mBU3G14fvLMLxpBnNkptvI8viyCGIboCF2lYk5ld1qaBildjKOzWA7E4KqY3zKA//RqEXI9tO2qs7JYuFlzw5I406/OUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=DeyYstSw; arc=fail smtp.client-ip=40.107.208.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nehGJzJABzVOF/qXblwfqPFxvdaeZXIY1rIubBO5LL3Gwt2IDQr4Z37NURHOFccY0fYlmka/NnPfLMyH3yCRcDhzbKtawxjRrH0Zc3uYZgxOvlTwp/xnvQTSvmOmXGAhQg9hYKBsKlfTA+rkqmzVrHq17f0L2sM6jsXLIV11XRWTKudWsd1V9+BuPShP+PHCZ8S97QsrvISDaJHDIhrf2yqtSFU7Q+e6wIUVFve+XAZMc7oOCj1SY3VsJ43klz8T885OAnhX1r1n0iQmRuh10ke57DiucB+SXC75RQArQonE0yIBEOE5VvpIT0aVu01DEnw3WfWjFgePkUKyvslNuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ECk7/f9H/ql18QtZ4/nIPZsRaS1rc0UWb/g++o2uoBo=;
 b=CdBU6ITxTleM0/NwqSpqlqovfIQ8wskZNShqv8zF4XK6G3qxYKSdFazp75d33gjmyg0DLNIEhSRoj8l0R749K/yzsXsrwS2/yyFRjjxYM+o6fJ8loy7l39icDj0e6rOkMqqqA56CrrBle08/mMchPLF8T6JHNGtfbkJs2iJ7L3F8FNVY5AU4RTQuaTYECQ0Xc83lgaVcEd/2RJJxhbm/f83gdYbHGRiPBr0KZfMrbdyuTrZkEFCh4xFcXRhQngGmYiZ5c0wS6hy/yFkFPyWe1vbl4jtlpa6iVqITUjXKv6u6SW4FoiJ3piTo8ng1m/bnl+rFdWAZNGhyAeXYh23mUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ECk7/f9H/ql18QtZ4/nIPZsRaS1rc0UWb/g++o2uoBo=;
 b=DeyYstSwBwNAnNtkdzhwvLfaPbIywwrlbudSQguXBDVU87WSeoM7LjoQedB5Yad7Pg4KcrtXi3+vMCOuk1lA7Av6b5unrRYNczHp8iNq8OvbgkaWD50mQ4MARiT2uu2vb8IUPL88UxZcdMHI7rJDHmX92KhH82x5mRrql+nftuU=
Received: from SA1PR21MB6683.namprd21.prod.outlook.com (2603:10b6:806:4a4::6)
 by SAWPR21MB6957.namprd21.prod.outlook.com (2603:10b6:806:4d4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.6; Mon, 16 Mar
 2026 17:38:35 +0000
Received: from SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219]) by SA1PR21MB6683.namprd21.prod.outlook.com
 ([fe80::879f:eec1:ca0e:d219%3]) with mapi id 15.20.9723.008; Mon, 16 Mar 2026
 17:38:29 +0000
From: Long Li <longli@microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>, KY Srinivasan <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan
 Cui <DECUI@microsoft.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?iso-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kwilczynski@kernel.org>, Manivannan
 Sadhasivam <mani@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
CC: Rob Herring <robh@kernel.org>, Michael Kelley <mikelley@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] PCI: hv: Set default NUMA node to 0 for devices without
 affinity info
Thread-Topic: [PATCH] PCI: hv: Set default NUMA node to 0 for devices without
 affinity info
Thread-Index: AQHcsnBlLEk5nWOmQkaR1EuarLdWWrWxavaAgAAEvnA=
Date: Mon, 16 Mar 2026 17:38:29 +0000
Message-ID:
 <SA1PR21MB66837DDAF5F203E832DA5339CE40A@SA1PR21MB6683.namprd21.prod.outlook.com>
References: <20260312223244.1006305-1-longli@microsoft.com>
 <SN6PR02MB415748A42DCBDD8AB635838DD440A@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To:
 <SN6PR02MB415748A42DCBDD8AB635838DD440A@SN6PR02MB4157.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c754b0aa-2f7a-4cc8-ad48-b237e59ca6b4;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2026-03-16T17:28:24Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB6683:EE_|SAWPR21MB6957:EE_
x-ms-office365-filtering-correlation-id: 3b85291d-51e6-40f6-8091-08de8382d65e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|22082099003|56012099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 QzyQu9EvKvgNyVfr99NLTxtLUnf+ykK6GDh+lanSKRLBomGjrwiPMlLCQ+CwIriXHzie9CgE0tQ5trBWU34Rrpi0K6/7Ag7NyRYNsE72t9fXrmsDEbkIKgJYCMMw1QWH5BX+ZW/6VFVcuKXFCNFml/sxs2dNr2pvP3t9WeYUgWZlwqVKn5IVLVau2ROHPi0kbk8vc6nCNwq5A+JUw9bUT1vM7UmosVKl1JFQhwpcWJpSHpHkuu/0ZkS/gqtcfDvtq2XmS8RKS9e7gfX8mQFCzulmYRpY2wKqp2wMLkrR3rFVp742hlx3nDBPPS8lIu6N7DAQTJWQz3OV1XJbAuTyL1tWi7nw4yCe1FACCbYtVXyAnI9B1Ev8l27utqG+jPoU1JY3jN94kVWKSS2f+Nfvg7HvI1OZ5tV6fcfAtMpeEr6SiEXD2VJ8NN4OZWfubYJx9J9jVCc1EQF+o45noAfWDFFwVIdrOkt1GDiDl3Aw3dyX3Ag67ilwfcRQyaPaQYY+Vf+SgEckZwHg6x0KxibalCQjS9UaCMoMMIOy5I2lOCgokk+c6MQ78b4fp6EZBHkzXQTz6AEODkljOCXha9M+E//RxkNQNdhmfIC2WLp4L0DXYH6XUmHzQVsqEX3wgawlKbyTJT6udtRK8yWPTkBn3XNXyd7ijWJp9J1fA/hB/SoN8Ax3dVmlTwRanKYKL1kFv9jHkGHA3SfiByBnw26HyeYITzqd1bKe2EPJspCkaB2HN4tOSvOKkWm6ILNE0e+5ODvK7YFYdwrm2AldC3YBY3TzbUM/7sG4XdCh1Htkm/A=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB6683.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(22082099003)(56012099003)(18002099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?76Je7pQoZrtHvl0KfK9rUsUOY8ZtbIJOqMcDQO841u4SamSM0KuB5I5PUU?=
 =?iso-8859-2?Q?PPY2UJ9sWOKPQReRJeOhaZrum0KoZc6qjU2Oe1bao7L3HD/j9HLfSum/th?=
 =?iso-8859-2?Q?e3Qpb4j0mzye12qgg2kFA2uFyc5sceLOie7uDoURyc8EUDU03gTTg3iqBg?=
 =?iso-8859-2?Q?zosYPI7MGxR1fCWruvUcKUJ+yU5HQcrj+Ufcu1ePlpNGLwh8i6MsGVN7qm?=
 =?iso-8859-2?Q?J1E6XI/kzY2Qeu8yIv6VRwxn8UrAcetcaPgeEicLwpXwGYgyETgHyPAuta?=
 =?iso-8859-2?Q?svhMugfqNxcAU0VXR9cpY3Nt/GLuKRvuxvjwblJ1DU7DzIRdH84rxkRLO/?=
 =?iso-8859-2?Q?Nc6a+Vo/7jVYBbPaTeG3rZUDfDqGkCSueEAv2xke3liEd3L25S4xvoqDME?=
 =?iso-8859-2?Q?B7SqHncYrk+CNEAtnGQlbgcoQUR8ZwAg52lmVCOIjxAWhnLyDJG7hpLWSK?=
 =?iso-8859-2?Q?shpa1rabZC9UFBFEGgjV9qqw9V+ZWLmLUfjUw/sCTTSkQoZ/H1a7lm7YMW?=
 =?iso-8859-2?Q?gCHPG6OEGJ1zRaXkWShG3z4HbJ4mNVj4mRkoLVF9U7ZILAArK5by1M0Nbw?=
 =?iso-8859-2?Q?A4o0CdR2EQca/hZ8BSlggnCfsKmFyhBGUdyguVIKU1W/gWE+IROtXcACFI?=
 =?iso-8859-2?Q?oUzPETP1XZxRYOoY/DqwJdAo0ndulJuAmGEjJmVX6o1xeyVpzZD/QBJnWQ?=
 =?iso-8859-2?Q?rKZwOmFTFnNf2YSmo+JZ14fiLpAb6V/Jc7YWTYAQgblWU0pIgBY5j69FmS?=
 =?iso-8859-2?Q?Vv84TjQauLhx909cgfJl8YDCtH80qM5zx4KQJ8CKzSV9/PkYnloUnRKHgb?=
 =?iso-8859-2?Q?ubH/E0fjHmFvmg7KXZaSAhvvGcBbcd2o14NDQQgXvrOhE9CB4ePfGb3wGx?=
 =?iso-8859-2?Q?kY6Vue2DsfRE+mTYv6iCSrDaDJDCSHad46qLvzUKho0p4JC+eG3tS7NCXE?=
 =?iso-8859-2?Q?L2tGvLvW5/+nwQH/1qa+t/2bEBJyOAz22cvLAgCQPH77pu/Jf/orcNvb6C?=
 =?iso-8859-2?Q?qXe1eBeeRRF75a8gF2mtC1ACFlrGbcQsrjO4ak0WbGvO6Ef+3XGjLX+1vx?=
 =?iso-8859-2?Q?Xv4X9Q0wIHJzL2iERzhc4sVxbAt7ujQfIaucKUvaEMIw5jcceMAywOE2So?=
 =?iso-8859-2?Q?5hP9/M4ZysYQlViDHni6DauV/esNN7IdxpsU46qUC+WUdXqrLGcg8b0Kpc?=
 =?iso-8859-2?Q?spB/MJy3oMw4mipKAKTAqZwbTmNLzo+8F9yI33w0CAXIjNvpR8Vtw5wUjJ?=
 =?iso-8859-2?Q?2KsT290PvKL1ywfzPptneS84bZ1GU5n7I6Uulx0N3BHqSf08+vf/TR09NY?=
 =?iso-8859-2?Q?hHdsPQCWsLWz5gfzS8Sl3l4PD9RKW8nMuFIhScLSbTyDlJ0JQ/NbYbVHlb?=
 =?iso-8859-2?Q?VAYB8+zH4MSPALkc7h0IM8sl/S4k74c1I1DtgKMLrYkUJkT0M7p7JuByGG?=
 =?iso-8859-2?Q?aWnVOTFG1zpYNKEbyFpDj1ZGztH524kVWLkKzBQe14fdrswImFokbJYZtr?=
 =?iso-8859-2?Q?m0yXFtCVoaWKSeLFQ+o77YITbnyP07kLAOBz68kpAJireHS7MNAxYpPP0t?=
 =?iso-8859-2?Q?uIUyo1+0wAdLqClffGVWESv96hGuWG8B1wCRQ/zohzB7m6DYrDdJXhjn24?=
 =?iso-8859-2?Q?9t0I0Jy/jt/Q6i0Iu55Q2eISZ0GtXsyHRqEYSVX1KNCeSEv/gzLVf1HBgk?=
 =?iso-8859-2?Q?bEYw2o5e9YAUef2vgaI3TnVLbBEPIp0dynfVEvHXkJk/c0zRjgkDcPTxOm?=
 =?iso-8859-2?Q?ht8ql28drBZ4gWYbSK9sNae/5s40ekSl8B+7fz7vOodAk5?=
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB6683.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b85291d-51e6-40f6-8091-08de8382d65e
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2026 17:38:29.8155
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jUqdLbCYsoGpGPSescTtbkzRXuf7+v0K2NNhLXwUk2Eclsn00vRz/wKV/WrLh6U7hFL4XOYEJDR4VXWytX72ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR21MB6957
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[microsoft.com,reject];
	R_DKIM_ALLOW(-0.20)[microsoft.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9445-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[outlook.com,microsoft.com,kernel.org,google.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[microsoft.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[longli@microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 4115229E6B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> Subject: [EXTERNAL] RE: [PATCH] PCI: hv: Set default NUMA node to 0 for d=
evices
> without affinity info
>=20
> From: Long Li <longli@microsoft.com> Sent: Thursday, March 12, 2026 3:33 =
PM
> >
> > When a Hyper-V PCI device does not have
> > HV_PCI_DEVICE_FLAG_NUMA_AFFINITY set or has an out-of-range
> > virtual_numa_node, hv_pci_assign_numa_node() leaves the device NUMA
> > node unset. On x86_64, the default NUMA node happens to be 0, but on
> > ARM64 it is NUMA_NO_NODE (-1), leading to inconsistent behavior across
> > architectures.
> >
> > In Azure, when no NUMA information is available from the host, devices
> > perform best when assigned to node 0. Set the device NUMA node to 0
> > unconditionally before the conditional NUMA affinity check, so that
> > devices always get a valid default and behavior is consistent on both
> > x86_64 and ARM64.
>=20
> I'm wondering if this is the right overall approach to the inconsistency.
> Arguably, the arm64 value of NUMA_NO_NODE is more correct when the Hyper-
> V host has not provided any NUMA information to the guest. Maybe the x86/=
x64
> side should be changed to default to NUMA_NO_NODE when there's no NUMA
> information provided.

Tests have shown when Azure doesn't provide NUMA information for a PCI devi=
ce, workloads runs best when the node defaults to 0. NUMA_NO_NODE results i=
n performance degradation on ARM64. This affects most high-performance devi=
ces like MANA when tested to line limit.

>=20
> The observed x86/x64 default of NUMA node 0 does not come from x86/x64
> architecture specific PCI code. It's a Hyper-V specific behavior due to h=
ow
> hv_pci_probe() allocates the struct hv_pcibus_device, with its embedded s=
truct
> pci_sysdata. That struct pci_sysdata has a "node" field that the x86/x64
> __pcibus_to_node() function accesses when called from pci_device_add().
> If hv_pci_probe() were to initialize that "node" field to NUMA_NO_NODE at=
 the
> same time that it sets the "domain" field, x86/x64 guests on Hyper-V woul=
d see
> the PCI device NUMA node default to NUMA_NO_NODE like on arm64. The
> current behavior of letting the sysdata "node" field stay zero as allocat=
ed might
> just be an historical oversight that no one noticed.

I agree this was an oversight in the original X64 code, in that it sets to =
numa node 0 by chance. But it turns out to be the ideal node configuration =
for Azure when affinity information is not available through the vPCI. (i.e=
. non isolated VM sizes). This results in X64 perform better than ARM64 on =
multiple NUMA non-isolated VM sizes.

>=20
> Are there any observed problems on arm64 with the default being
> NUMA_NO_NODE? If there are such problems, they should be fixed separately
> since that case needs to work for a kernel built with CONFIG_NUMA=3Dn.
> pcibus_to_node() will return NUMA_NO_NODE, making the default on x86/x64
> be NUMA_NO_NODE as well.
>=20
> I've tested setting sysdata->node to NUMA_NO_NODE in hv_pci_probe(), and
> didn't see any obviously problems in an x86/x64 Azure VM with a MANA VF a=
nd
> multiple NVMe pass-thru devices. The NUMA node reported in /sys for these=
 PCI
> devices is indeed NUMA_NO_NODE.
> But maybe there's some other issue that I'm not aware of.

Extensive tests have shown defaulting NUMA node to 0 preserved the existing=
 behavior on X64, while improving performance on ARM64, especially for MANA=
. This has been confirmed by the Hyper-V team, and Windows VM uses the same=
 values for defaults.

Thanks,

Long

>=20
> Michael
>=20
> >
> > Fixes: 999dd956d838 ("PCI: hv: Add support for protocol 1.3 and
> > support PCI_BUS_RELATIONS2")
> > Signed-off-by: Long Li <longli@microsoft.com>
> > ---
> >  drivers/pci/controller/pci-hyperv.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/pci/controller/pci-hyperv.c
> > b/drivers/pci/controller/pci-hyperv.c
> > index 2c7a406b4ba8..5c03b6e4cdab 100644
> > --- a/drivers/pci/controller/pci-hyperv.c
> > +++ b/drivers/pci/controller/pci-hyperv.c
> > @@ -2485,6 +2485,9 @@ static void hv_pci_assign_numa_node(struct
> hv_pcibus_device *hbus)
> >  		if (!hv_dev)
> >  			continue;
> >
> > +		/* Default to node 0 for consistent behavior across architectures
> */
> > +		set_dev_node(&dev->dev, 0);
> > +
> >  		if (hv_dev->desc.flags &
> HV_PCI_DEVICE_FLAG_NUMA_AFFINITY &&
> >  		    hv_dev->desc.virtual_numa_node < num_possible_nodes())
> >  			/*
> > --
> > 2.43.0
> >


