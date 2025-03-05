Return-Path: <linux-hyperv+bounces-4221-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37203A4F60F
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Mar 2025 05:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 628327A51B1
	for <lists+linux-hyperv@lfdr.de>; Wed,  5 Mar 2025 04:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C5E1C5F13;
	Wed,  5 Mar 2025 04:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Q7j2p32+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11022138.outbound.protection.outlook.com [40.93.200.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930911B4248;
	Wed,  5 Mar 2025 04:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.200.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741148916; cv=fail; b=SyEe/Ql87j8MnxRXG1mZySba5Jl05MHcF1fqW8CmogLi3o0pUM84/cBwb5ieA3b0BaHLchuEygh17GdfeKIZ9v7pcamBQpchbrDD+ifn4G9KmSVjB2LGiwD+Um+qFB2/Jl9Z2j3+8bTRtP58AcKlNMN3fZhswovzqHJ8f8v1R1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741148916; c=relaxed/simple;
	bh=pzMfU+gp20nu76v/wvMWumeClZFB3n99KIHjJjq197Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Hw5eBCihJdpwnCTjP8SglGzj992e7UmZ6Ey8hDZZMC9gvKBvjfjgCw12jI/1a6zKBSHvAQ7YIo3LcwKCahk/h2GuIVIFBedlYIVYEzpd2WtYycenRXEoCo5irMaXIlTECsUbx+kp+Ce7uOumsb4WMYgDM1y84hHAWaSdb4vjKzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=Q7j2p32+; arc=fail smtp.client-ip=40.93.200.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BUQd6vQGgsrQXM0XaLj/X+HoA6KKg2nW2WGMSdbIYZJzcd9Zt2LER2ubqnfbrNkYbPcClXYwowyoM6fw2QacAFZpQFk628m7W3wcrHTNBbAU1v8Q/tR3+z09hdBlMKv2tkTmDQvJv2aovlhLhx4ltJtPKUHrw3YXgQDbIpke9vSimsZBWsM0pBWkIzPwub7300Drv4Sbt0doiWRrTyp9esJ/O8pCpX0cMv+5oOzdDKLc0pMNfr5bx7zLBBxDAmrxqWdiWBsuNM89czjJ8CjOhS5Lra2tip4qzMl0kTtPAzdDHXiOtTjyhRDb60ml1es6hJr+ljxOVUVk4NM6gBUu4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nm2p65vLClKAm6dw+g/Xb94C5bsAEDXF7Pq8iVPdenk=;
 b=HbuQbxhlF5VevXNB5WG0PkzV0VixELGjPinnRuC408eQFgGZE4lol+yGbuy7Qz8sW4OCJmyVz1NOisBwYX9uduGgwrHZlYw0zCCgg6WiYQVN73YVKEh8w3V6SG3yx27pZrCUf5eHTc9YgqU5QdkKlD0EbsCa1Xsur9D9Y2T5k3KsHgUAmy4HT4oxcRVRxPdT12Px8LVUUYnWWwRjtZvv7JVUPkwA5JPoqbkGS+dEwexDG0HGxoVxr+1CShaZaDzXq+GbNlmyJMwDyYo4WD3ME7M9bCkP/bKLdgX8SCQppqHY4vrgjO0rVkoaUhMIZ4FIP8BPMw70/62go9afPlExIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nm2p65vLClKAm6dw+g/Xb94C5bsAEDXF7Pq8iVPdenk=;
 b=Q7j2p32+olaymqR9C+ddotnGiorWAPjsX3PMRxgpagKnCkenMeiWXMn007Pph029L48NtEh+PxB+KnB81j3hYOkTIAP2pksuHbDPO/3n5xLCm6DqSTG5XlxKDParnJBiNp+BubBTGwXqAka49sh04AiPCvY2Qdgurm4jSg7KU1M=
Received: from SA6PR21MB4231.namprd21.prod.outlook.com (2603:10b6:806:412::20)
 by SA1PR21MB2065.namprd21.prod.outlook.com (2603:10b6:806:1c0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.7; Wed, 5 Mar
 2025 04:28:32 +0000
Received: from SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff]) by SA6PR21MB4231.namprd21.prod.outlook.com
 ([fe80::5c62:d7c6:4531:3aff%4]) with mapi id 15.20.8511.012; Wed, 5 Mar 2025
 04:28:31 +0000
From: Long Li <longli@microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>, "longli@linuxonhyperv.com"
	<longli@linuxonhyperv.com>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	Konstantin Taranov <kotaranov@microsoft.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>, "linux-rdma@vger.kernel.org"
	<linux-rdma@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [patch rdma-next v3 1/2] net: mana: Change the
 function signature of mana_get_primary_netdev_rcu
Thread-Topic: [EXTERNAL] Re: [patch rdma-next v3 1/2] net: mana: Change the
 function signature of mana_get_primary_netdev_rcu
Thread-Index: AQHbjW3mh02lTBwq7EquVhpKNEKkTLNj8bDg
Date: Wed, 5 Mar 2025 04:28:31 +0000
Message-ID:
 <SA6PR21MB42316173AD04AB73805BA8E1CECB2@SA6PR21MB4231.namprd21.prod.outlook.com>
References: <1741132802-26795-1-git-send-email-longli@linuxonhyperv.com>
 <20250304172821.5cbfad8a@kernel.org>
In-Reply-To: <20250304172821.5cbfad8a@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=31e6b6e4-72ff-4b29-81ce-b1ad58524131;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2025-03-05T04:22:57Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA6PR21MB4231:EE_|SA1PR21MB2065:EE_
x-ms-office365-filtering-correlation-id: 0651d80f-fd4a-4b7d-07d2-08dd5b9e2f8b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|10070799003|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?fFHR2VDbF8PGZwgRBLgi1mJWjgPw7fFWTf5IIO9IIDh7wjd1nXQWj3M861QA?=
 =?us-ascii?Q?1/qivNk938BbNoYZfdcdaIN+yTRGhrnSFGnCbHHpoiaxOMMEgN0H56BWaxvi?=
 =?us-ascii?Q?xvELSjpTQ6OAlMvN/CPlxRJxl/l2dSc/7GZSDV4FrWXEVmtY9Xh+xDTTpDUk?=
 =?us-ascii?Q?mPvOh7RxSW1uwsnKM+T/Yq30Lvnsi3mZTGBbOI8dETl8qxmc8CGEcxBfMqzm?=
 =?us-ascii?Q?vpWW6OmCSXHLBHjhnjVSI89eFyv8ZED18X+2A6qqHTxjY/c/VCUDdFbtk/uY?=
 =?us-ascii?Q?Nva0ZnflZylh7YRGcXlceJTZYFLaeoi/HOJ5NYdHLrnvAhYfoSBx1vJY6+hD?=
 =?us-ascii?Q?Q/mwHP2SbigtTh8ia5/fRXq+EZEGZ4O/+LnhD4Tm7HqCX/OmGJ2ElnQBO1Y3?=
 =?us-ascii?Q?6otPSWJa1OIjr45XNPLEyf5seiC4lzEYHEEZkPva5wnYWWjASQq6NacOrEN/?=
 =?us-ascii?Q?CpwQqmbUj0anNSNP27fpx1faMc5+LbspVj+1sufACH/CsVVRssYRMfcDzXO7?=
 =?us-ascii?Q?xsT8W8rfF5/mP/yZFmuE4bRaXqzN9HX+gx9qnP/Ba01hpHD/eCmlAjaArITJ?=
 =?us-ascii?Q?HGj6oU9zvyY3JadTjGORUTVnXZ2S8YXYX/dC5mHZn10O0gy+O6rjXjHVVuMN?=
 =?us-ascii?Q?GLKEwHH5OFghKldyLGCPYvCOz28atagBHp55eIlQtcBWit4aOAqad0+ay+nV?=
 =?us-ascii?Q?HXGl1sTQEJjo2sjqVz20bu25Y6LGr5R3/KLa6ufgIRzo82spELWK6CS7xIf1?=
 =?us-ascii?Q?fNJoACnBQ+QSsJRpt9WWFCteStI0vipZhha6NyjFtaOIervHDsTlMmPDtf0u?=
 =?us-ascii?Q?1okUaJGp8MY4PMd7uoenoOwto2LbbtL14M3ufPH89kEnedm7hYC43ROsGNSG?=
 =?us-ascii?Q?yVTm6wvSoRVLgB/qEJN+6bwhMzRyxkbVXOEQZrmOk0pxPOVxGpZhTvty9pua?=
 =?us-ascii?Q?GenPVM7yy4OJfHPqVCFmNkRQzP2IbwPV/zoT5mcEKqp0rOYuSENY/hw21g2x?=
 =?us-ascii?Q?b3rB4IWdDD125YulUMkx8/StY7J8DE16qIKWaHK206PdL1sdq5/AOHXrJf/6?=
 =?us-ascii?Q?RXZZWcTQDxtnHcB+BWfWZBxT6wHU2PZviqc/YgAKAx6/8PR0lC0IaooTYTNw?=
 =?us-ascii?Q?24BP0dA+d3M85VRZ2K1AAaARmgsQBYX667xlQxbh76XkICcIEMFGhllad02P?=
 =?us-ascii?Q?sk6CMBSLa0pu4DUk+7xqKOO7h1Ab10LJD0oEwUr9DzA+jVl0UJVA8qYSyB0S?=
 =?us-ascii?Q?5Dx4FiFC5jDv/g53pEdvXmaFUTUTwRmeYecjn+9zXAxGEBFYGrhvi7t2MoQR?=
 =?us-ascii?Q?1mb42Ok3Sz84Alc4og1PBgsPvHlju9iUUYcC/Y4ouEKbsS0VlOuobmlglHSr?=
 =?us-ascii?Q?onHyB6xLYgHzu2sUrb7I9KhgS3L2d7gHwVEMfsyoBpndC+I1/w=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA6PR21MB4231.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(10070799003)(7416014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?rE5Hkg/DEGlvgNl/0wIkte+bX7D58iKfXB2ptdWj+11rZuhRB4YiP/iwH95N?=
 =?us-ascii?Q?oIwEMLw7mKmeer2EkpqxfrdH2n+9x88a48TMhv+XMWlwj8mQRoGZZa9ucshv?=
 =?us-ascii?Q?yDkrqnnn/fbabta5VouIV5Wea8Fvxs11pJOn6lyXGwkQFk7OrCcm6qhmsStT?=
 =?us-ascii?Q?t6BZ1nw1aB3EH11u83N+oQSOUH55Pn2UumTi0wb60YBMq1DO3qWVTjFiooI+?=
 =?us-ascii?Q?ON8Or+xmZdfaHikJBGN5TxK+yTeyajnMYawaNdiphillSokG2zi6/Glm8KdA?=
 =?us-ascii?Q?L8dGilswE60o0OingqcnMBrUc5QaYOrvzEhYLaqkKx/pnMxs0R8CEAigBS32?=
 =?us-ascii?Q?PSs0CViJFZOabujICcwIhljvJ0j7HOlfiS9Kw6Z3VjEi6DFpM4cUFFsTAP+D?=
 =?us-ascii?Q?ojguhpdazkPPy1Vnn8aSr4lR3FUguzH3nfu0AxilBVsU16wPzJcby1ctSOrW?=
 =?us-ascii?Q?YwnlzLPszMgr9WpPw0aHQqy1aRig/WLpLViPNJZNa+sOOf0w+bOujmytxyuS?=
 =?us-ascii?Q?mcZdiyZWhIkISCpfz4QWiDg+vUrRr2knZfq5LcvyfA8BCNiPzjmfOxqDO2hz?=
 =?us-ascii?Q?OmjshutVRl9Jo6VLTj+YvVtPfdPie0030PSUt7uDZhT+BKUZirS80w1Twl/Y?=
 =?us-ascii?Q?2DX57061w+aUptQbsBXNEyq2XJY+zZ9e5pG25DF57aIVmtW7GS3UQceIukQU?=
 =?us-ascii?Q?Qs9o+SRYMaUi64s522+G5wKJIAQinUmA9pOjpIJlz4TGZiLg+TQt68y+ieBt?=
 =?us-ascii?Q?gLvvV1oDin26xIDdHtGuvzuy2zhypRWcCsPh6o3etrl7a6FSwd5tJUwtQ9hD?=
 =?us-ascii?Q?vHl0zXjrZZry7fZayWcASov4tgv2KgfhPA19axY4fcp/OP5pDKRQU+9Gfrsw?=
 =?us-ascii?Q?wW+nlRO5qykySQHXjBxrp+cffgrNnYc6iRHOCYkncK1QcP7IJOezXxmNMg2S?=
 =?us-ascii?Q?euL+8w6pYJZ/hjyGWKMU9HbHuSra7f2Jo+07WIgIgR8/jW4oN8ICPRqKzqDy?=
 =?us-ascii?Q?RAo3/9E/XDNOcpI1XPEy1SzAro0hwHouk5nTUECOpm9siSnPnE9BnqX1jLFT?=
 =?us-ascii?Q?G0Ow3NeCIpSNkczVIvX97JLvmad4N2Mpf38npi5OLSMhWJa9N0sKSZOUUSM1?=
 =?us-ascii?Q?hqEHSf3CqWECoadSU8NcA0cJh9gNZTI2JAPp8ofzsyrKr1dwij0C25gejmqV?=
 =?us-ascii?Q?yzF836E08RmP42TUxtYVr7zd/ptl0gvn38lx9W71TOSQVsUnuHYS8coNGd1W?=
 =?us-ascii?Q?LJYdkNWNs9rYza1Z5bA7gAZpzH+HuC1hM4BR2QNo/KsjcJ+RuELhi/iV6y9U?=
 =?us-ascii?Q?0lP1l2Yd8shBQe71Ti/ZwrtNBzBFFFqOmnqNJUhUAQgvouvYAGWER0Wb9mL+?=
 =?us-ascii?Q?AX8pj0xsgMWuF7tgcVM0bqAAzOCrX2JO+FgSejkupW2m6sd+HN92HTu5eHKD?=
 =?us-ascii?Q?1mAVvccZzCe3qo9VPVLfK0ksWCZCgrzYVHf7iVELrljtuqPuLk51tdCK2Ody?=
 =?us-ascii?Q?/M+OrC35JQ9auJm6TFvxmaO29/wrMnMhWVL/ST/DdxTJjlCEzJkoaQuz5qbN?=
 =?us-ascii?Q?Vq4GmIZ8KqHcRrvTwabFh3wvxBCgnh6mxLvs1z0Pf9xcCv4X0QeprKBn26ZZ?=
 =?us-ascii?Q?wgqdBxUWG9AICqN5uGeLeTIJk430W8NNIDyiNOX31Lc8?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA6PR21MB4231.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0651d80f-fd4a-4b7d-07d2-08dd5b9e2f8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2025 04:28:31.6692
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dj7USjiYdYd7GUpt/dEIpjanCyAyGWM5VXgRICSOq8IA7eXx5wR5F1HC8x3OqlBoH97G3kUubMftVoGOmq3vqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR21MB2065

> On Tue,  4 Mar 2025 16:00:01 -0800 longli@linuxonhyperv.com wrote:
> > +	dev_hold(ndev);
>=20
> netdev_hold(), please

Will change to netdev_hold().

Is it mandatory to use a tracker, or is it okay to use NULL like the follow=
ing code:
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c?h=3Dv6.14-rc5#n8=
37

Thanks,
Long

