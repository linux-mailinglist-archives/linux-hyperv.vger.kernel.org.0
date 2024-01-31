Return-Path: <linux-hyperv+bounces-1490-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B49C844655
	for <lists+linux-hyperv@lfdr.de>; Wed, 31 Jan 2024 18:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAA6728A0BA
	for <lists+linux-hyperv@lfdr.de>; Wed, 31 Jan 2024 17:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C71312DD92;
	Wed, 31 Jan 2024 17:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="P30iVNDy"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2105.outbound.protection.outlook.com [40.107.102.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7507D12CD86;
	Wed, 31 Jan 2024 17:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706722824; cv=fail; b=gMli7G2cPc2ypWQsIe1rRISiDa+Fi6pq1DqD+KdHhyppYaNwSI8fuNqi0hYPhLVe4xHyaydHfK2Wk4KP8t8eg37lV6EzmQ8LWmYoAl2QPxIKQVj9aYJJ3DhIct1qLTNLPbgJ3Zu4keBhCX3ZTjXCLel/sX3TuN33I12dYhK4pDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706722824; c=relaxed/simple;
	bh=urgceumXJJmVvmJ8XBVvXuDxWQRL5iqJH73dk+05rVg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LIHcCkHn/czVq6AXkmmcQqPBjedEknCs4R6xZjHM80tg5e0ooirVuC4Wz3d+96c9r3igR/xh1JufDlln0wWOyIENufphXDZJr3cr0VXEWUfy79k2IKsXk6Ymi/qEcE7hDiegRYdGaODw+pJG2Nq/IqACijibqgbD4W7RZvoASjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=P30iVNDy; arc=fail smtp.client-ip=40.107.102.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SHsOheAiCczY/2IjykgWi6/AAh6br7V96ZPfPMrriOWXyplTilaKognB3lzBpj8F3hHW0dpZsXxkUh9DL0W1NVaSNXtDFJm1ZTEg83g8rhXl18SIJ5nAT6TtiSrIDmXxQ482FYPpHF+6pW6GgUadk1MtSXaSEx5QTn42X+g/sQm3d43R1SZndtvVb2BpZm+R+5OeoBv6YlEywp/q6OvWxAwT1+FgNs8SqruJ9+8JS2Xz2LL07kQvJoZx7L64ZeqH/5q0gkzBVEaL8p83W8s59DKqstvAYLLSopzfthF4Qr95HgeFMG1O6U2pHeMtKPP20dWHiuzK31A1u4jVqxi/bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YeHUgy1ef+J8v0xmlX72sUawd0eRsH3koABvexjzjM4=;
 b=BvcxQEcQTNBdWnkN+/JajwlOHPS5Kd+ZbdiLmUc0/KgCnOvSNRQJf1yy3hD+qBrAnrzpo/r/SqpahDCKsCyDuPRfZDktBRufz/ojlSdDkaiLUagNR5XeYzfhf1kiw3MpXYsfHBh8QKX/jQNc9s2lBPWi9bpoUdsIHCf5+uqnAAf9+nia3Tvr91vfVIOpi5rMSH0fZSP6AWCspiuH+jcdPyjw7QU07IceWKJOfiUqpglZR5EZhjKqFRF52DckuK4Q831xzF8WTP2QqoEv5CbqBeXw33jCUbR1YgZ9Rjy8SxoOGnJVslPQWOlQY7nsfVPChwOMxzpqwxACPBKQowQQ1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YeHUgy1ef+J8v0xmlX72sUawd0eRsH3koABvexjzjM4=;
 b=P30iVNDyfr3PCh0011d+SUmQ0QmPgj+beGSQnAB9Z/QINVb5U4CIowTrpGdzEwOUpmL8/P1tMFsETH72fUtJbVuc3XyUf2Vfh3rzj2oGyN4nNIZvuGkYIoNnMO+zxIqhZ9/Lg6GE+oOLnzr3+9V7JNOJqWD9NDCzliZjHKxtz64=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by CY5PR21MB3770.namprd21.prod.outlook.com (2603:10b6:930:c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.9; Wed, 31 Jan
 2024 17:40:19 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::5d07:5716:225f:f717]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::5d07:5716:225f:f717%4]) with mapi id 15.20.7270.007; Wed, 31 Jan 2024
 17:40:18 +0000
From: Dexuan Cui <decui@microsoft.com>
To: Haiyang Zhang <haiyangz@microsoft.com>, Shradha Gupta
	<shradhagupta@linux.microsoft.com>
CC: KY Srinivasan <kys@microsoft.com>, Wei Liu <wei.liu@kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Wojciech Drewek
	<wojciech.drewek@intel.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Shradha Gupta <shradhagupta@microsoft.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] hv_netvsc:Register VF in netvsc_probe if
 NET_DEVICE_REGISTER missed
Thread-Topic: [PATCH] hv_netvsc:Register VF in netvsc_probe if
 NET_DEVICE_REGISTER missed
Thread-Index: AQHaU0yZPmSUZITQDkq6vegFrHdKtbDyyvGAgADDxwCAAI9LcIAACpLg
Date: Wed, 31 Jan 2024 17:40:18 +0000
Message-ID:
 <SA1PR21MB133546A5D3B1E471E4021A00BF7C2@SA1PR21MB1335.namprd21.prod.outlook.com>
References:
 <1706599135-12651-1-git-send-email-shradhagupta@linux.microsoft.com>
 <SA1PR21MB1335C5554F769454AAEDE1C8BF7D2@SA1PR21MB1335.namprd21.prod.outlook.com>
 <20240131075404.GA18190@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <DS1PEPF00012A5FD2F8DBDCA1A0A58C6AC6CA7C2@DS1PEPF00012A5F.namprd21.prod.outlook.com>
In-Reply-To:
 <DS1PEPF00012A5FD2F8DBDCA1A0A58C6AC6CA7C2@DS1PEPF00012A5F.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=94a4fd25-9eef-4088-8818-4ef9b583d8ec;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-01-31T16:26:55Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|CY5PR21MB3770:EE_
x-ms-office365-filtering-correlation-id: b54e467b-1ba7-47f1-50e3-08dc2283b136
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 rqo3ZVTg99ZZ6f+UJ3y6EjFWrAI0rJa0PVfQSx81RcRLLzANLUiHL8X7QOkNwLV3gW9psTALIecm4pxAzdSyODDb0X3In66CIHb4KoqXT8qUrMFnwupLGDNvizpTieqUkeyTDVLa0dC08u6/ba7Q2ffRnqbiQIRZujShEVw6krO32o2TDtxSmdQp15jmeMCN4tUVEBfFwubXiuhVuaXmDuYrbjRgTFLj9X5co6Wg7MVSPTTelRw5qmpmbPr8g4Jz4b2lvuD0yT7/6Lj+jeiK8wTWQq2alfjQ7vexP8DTO3+yvsVcpTfcZp93oZ33N7jtK0H58oC3fU2bGKhdEIWNVSVViLId3LHhWfqYDyiCjR2PsfjfSD4XHRCVsrvhDGb5K2wVcPI7o8k9uxET4m0d4F0Ui5gxXd0rlTGcSDJ/Ih7FV/QpL67ZyPazgJe4P36hdGHWlhGwF9sjlvx9cDpYZbw1UaZ740CKZyoaKGpQ3XYo2vntmP9fOB2WpsStMN4mgDtabe7khfi9wIOkPbCU8l/IxhF1dHVey33iJ2y/LZgm9WJi6B4JuGPPB48nIjtjbXXRNEfvXie0X5Rpo7Wklk8M0YOeDWCJM7V/X616RtsqRR28zNv1URSMsYdQvFpG
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(376002)(396003)(366004)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(26005)(38100700002)(122000001)(82950400001)(82960400001)(7696005)(6506007)(4326008)(8936002)(8676002)(66946007)(66556008)(66446008)(110136005)(54906003)(5660300002)(7416002)(316002)(66476007)(2906002)(64756008)(52536014)(41300700001)(76116006)(71200400001)(86362001)(9686003)(8990500004)(10290500003)(478600001)(38070700009)(33656002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?VAPdCy+GMtJps8eVWO6RqlD8RqHxmyPQfaAyIb1on/Krd9+JA04vBD9Z63O+?=
 =?us-ascii?Q?FODtmQUGIWUM3LR5IWjxdM7LWYVr5AgCEqRTIvdZCF0UC5dNOvZkPxxaunUZ?=
 =?us-ascii?Q?VTb7926CWoUZBrlqiEFtxQ/NeOLSEnF2gkoWKH6KjlUC/MQh5RzbG9zKNqqP?=
 =?us-ascii?Q?ZLN0RxLcv5UPxICYDAvhZMiWewg2jE3eZQ3aoNzexT+yLojWi++UYKrhi0Xk?=
 =?us-ascii?Q?2xlIVYEyA9K8fpIde9aneIr4iIEAJdTbX2G10nxBUjiD1crQHpytxOXq8ucA?=
 =?us-ascii?Q?9z0XfWt64bk6llyEextF8jiF2VS55yktFw7jnNIs+micyhELIQZgEqDL9Cyn?=
 =?us-ascii?Q?zN1z7LUiNlnH2kBLr0AnY9hHdaxEUa1ce/AiD+ADWUsgZiP45LyUoc+4hHrH?=
 =?us-ascii?Q?TiRxsyQKk/WAXoZLmqSVMNWAOYm0asuoybI1wI6DlL0kZqC3kpBQC0f54GNB?=
 =?us-ascii?Q?TCDpJ6Ih1FV3raflIzhXtxkixeMugKj4gjHtRSMWziYwEmQUD/mlrY+mPs+C?=
 =?us-ascii?Q?kEMrO+z85/E5fH93jXWEZhFl7Rd4GBctzqmq1ZIhxOWLi6PVcdsAMVs+sMin?=
 =?us-ascii?Q?1oXmm+u/dxAfAPHJkP99Qny3di/KsFCMDh0OeP5WFHavlmmS/8Aa+gW3T15h?=
 =?us-ascii?Q?jfVFlQr7dY3ZVXzT+nMYmLOU+1RgDzQ3pFuOpPUxeWGKMmCL7jrOmaXN5PYM?=
 =?us-ascii?Q?sH+Qs5uB9fV1nrGxbVKoj/kajZyo35XrVpmbPBmcKP5VwofKI8BzoMVWfAQ3?=
 =?us-ascii?Q?hOQ5/RXAmT950zvNpA2g4y2StBHL6FlKS03c9yNG07JNeYAKQgmkDJJSodkl?=
 =?us-ascii?Q?aYLKt51eZgmmVMgfZr87aQnTER0rwfUB5CRmsM/LuZ9fsrhjRyLV2bcLue7I?=
 =?us-ascii?Q?zGEs2Rtls6Xk4qZrN4Lt6VmyiWxZJwbHuZ11IFCWtUuMeD4WxEiTc11KZDx6?=
 =?us-ascii?Q?BfQ9GnMAr+RnA62oheZRHOEOm/mfKlRORUnOczPaS9VX4qjH1jFDAiwacThN?=
 =?us-ascii?Q?xUar3LVDiZaKIKsI2bv1f90cD5pBIjYDnlM/EeplZxYFr/ZFBH+gBQ4855kB?=
 =?us-ascii?Q?1/LSu64AAUyJtmBNaypvUG9i/P9Hx8TOj0qbQbr6Ewovid+orsypefbkjj6O?=
 =?us-ascii?Q?qszdSa77cB9XP66CFGlFEPzPGvqCwec8Qcsmky6riGic4yN1rUXEZQUFGwZC?=
 =?us-ascii?Q?ebeyscIp5VviQ26KiZUQ6WcjrifNEv2i5ooWn8gL0IaZbrhczA6mq4YPLzY/?=
 =?us-ascii?Q?diDsH4QVtSeMU5om577AVuuEETL9G2w3812z4WiUApEFAa2fIwaczEDXnyQA?=
 =?us-ascii?Q?ikfOX4yhJW6TBYJNO9jCd2HwzDcaCP7qHsFw9htNhEnMso2kLX66Q8vILmno?=
 =?us-ascii?Q?pTIoPiff4qpqNxLg+dJVyW8Bazl/c0aNaGnaS/IzV4fMfgsv8jspIy2iRlTw?=
 =?us-ascii?Q?zrub0dx+8NYR5t+bd3RMicu/MXJWrjvL6NQKKThXsOG58i0L2K7tJGynJVxM?=
 =?us-ascii?Q?BDCh5W+J8FpQHrXYGOz/TXaA98A4R9Bn9G3T6xr89NmN54/KhbRwQHDILSbt?=
 =?us-ascii?Q?hmhO+bdqaP3SK3pinbalS9hFnnRm9+ZQIjf0pk+U?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b54e467b-1ba7-47f1-50e3-08dc2283b136
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2024 17:40:18.8362
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BlbvIRQn2uCTNCkMK4p2E56dOdtwVpH1LtEJ8SBNee7oyrWzgwfU5gzZEFJSa+/pIxbEVV7qRKLnhtnDt5sKGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR21MB3770

> From: Haiyang Zhang <haiyangz@microsoft.com>
> Sent: Wednesday, January 31, 2024 8:46 AM
>  [...]
> > From: Shradha Gupta <shradhagupta@linux.microsoft.com>
> > Sent: Wednesday, January 31, 2024 2:54 AM
> > > [...]
> > > > +		netvsc_prepare_bonding(vf_netdev);
> > > > +		netvsc_register_vf(vf_netdev, VF_REG_IN_PROBE);
> > > > +		__netvsc_vf_setup(net, vf_netdev);
> > >
> > > add a "break;' ?
> > With MANA devices and multiport support there, the individual ports are
> > also net_devices.
> > Wouldn't this be needed for such scenario(where we have multiple mana
> > port net devices) to
> > register them all?
>=20
> Each device has separate probe() call, so only one VF will match in one
> netvsc_probe().
>=20
> netvsc_prepare_bonding() &  netvsc_register_vf() have
> get_netvsc_byslot(vf_netdev), but __netvsc_vf_setup() doesn't have. So,
> in case of multi-Vfs, this code will run "this" netvsc NIC with multiple =
VFs by
> __netvsc_vf_setup() which isn't correct.
>=20
> You need to add the following lines before
> netvsc_prepare_bonding(vf_netdev)
> in netvsc_probe() to skip non-matching VFs:
>=20
> if (net !=3D get_netvsc_byslot(vf_netdev))
> 	continue;

Haiyang is correct.
I think it's still good to add a "break;", e.g. my understanding is somethi=
ng
like the below (this is untested):

+static struct net_device *get_matching_netvsc_dev(net_device *event_ndev)
+{
+       /* Skip NetVSC interfaces */
+       if (event_ndev->netdev_ops =3D=3D &device_ops)
+               return NULL;
+
+       /* Avoid non-Ethernet type devices */
+       if (event_ndev->type !=3D ARPHRD_ETHER)
+               return NULL;
+
+       /* Avoid Vlan dev with same MAC registering as VF */
+       if (is_vlan_dev(event_ndev))
+               return NULL;
+
+       /* Avoid Bonding master dev with same MAC registering as VF */
+       if (netif_is_bond_master(event_ndev))
+               return NULL;
+
+       return get_netvsc_byslot(event_ndev);
+}

+	for_each_netdev(dev_net(net), vf_netdev) {
+ 		if (get_matching_netvsc_dev(event_dev) !=3D net)
+			continue;
+
+		netvsc_prepare_bonding(vf_netdev);
+		netvsc_register_vf(vf_netdev, VF_REG_IN_PROBE);
+		__netvsc_vf_setup(net, vf_netdev);
+
+		break;
+	}

We can also use get_matching_netvsc_dev() in netvsc_netdev_event().

BTW, please add a space between "hv_netvsc:" and "Register" in the Subject.

