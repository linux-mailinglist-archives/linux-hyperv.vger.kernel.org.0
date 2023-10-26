Return-Path: <linux-hyperv+bounces-605-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BEBD7D8A05
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Oct 2023 23:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14ACE28210D
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Oct 2023 21:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A3C3D38E;
	Thu, 26 Oct 2023 21:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="IgWwhsm1"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AB24426;
	Thu, 26 Oct 2023 21:04:50 +0000 (UTC)
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020003.outbound.protection.outlook.com [52.101.56.3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA3093;
	Thu, 26 Oct 2023 14:04:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iRQR6MX1wKUtoPiaZ6WhV9LnvSwVbahzvhYsObFE8ma34XMgAcTmRoOA5GOoieW5v2HDGSesn+XDIlnlQLF7OSs2Q++SEEd5bHyi+xmRpV/vwak5lSC1ClU9YgOCWytrrAH4cOPR99Y5WqS1PfYx/skOVh3fdX0WsVcgzOFgLVYoTzwx8F2Xube2KBBg9fQ/ePeo9TG0OG60dPOKf/jDpeoNMtqs4n5k4l5FHlqb/lLIDiV4NzKjBqO8gupn5IYzo/mNA0eqvSSFe19tuBJeTb7MLp07jIdq1dFcA85pLmUY7T6oQaFHgpw5neZEal91k5CZxyyKkoICpvr2HNYtZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DOkExkBFsJbVMSx7K889g30PSBmC7cm9s584MhEmJjQ=;
 b=CT+hCJtwZR2FxUsvwYu8j2Sq9n4pdf9KpV1lTbW9U0MFFUd9NjKIZGM5iiVqAs2LELqm7ja1BP5u6yJtNmdcbMsCOlUz96DzbVyP+rZ/RsFBZWkRI8hru98NFi5iy4x4wVw+7HW/+quuCrzb5FFgaZURUPd80R5KIfu0qaMygb7OubeJBBD7hUQaQEQhhMaikOB6rd7tDrYumQtLIoGG6WCnStTt0SVLh6nOxdK9BATuegZk8kXReBYZptmD4hyCG4fJj3aA8ERY6R/kM1zjKPwDFEcPHMTWGD45pfwIJaPAu/Jo0ViefCF/njedhXiH5Q3JbOVAhevbTP93VrfgSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DOkExkBFsJbVMSx7K889g30PSBmC7cm9s584MhEmJjQ=;
 b=IgWwhsm1I7e4pQQcfFLbuYgdu3bvdXyKlOJeqL319weOYqIwdFFjSvx6Voz7GOzC/tHgHhMBq3RxoBvBPvKvnuNAq/44TiZWsibxpyLxEZOLbDg/CDq00ROg/Mo/+IfQLmxwCIxPlpRNO39+MLkxDdFA78X9WmKud3MVTzHmQs0=
Received: from MN0PR21MB3264.namprd21.prod.outlook.com (2603:10b6:208:37c::19)
 by DM4PR21MB3440.namprd21.prod.outlook.com (2603:10b6:8:ad::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.8; Thu, 26 Oct
 2023 21:04:46 +0000
Received: from MN0PR21MB3264.namprd21.prod.outlook.com
 ([fe80::9f51:f462:e8d2:d242]) by MN0PR21MB3264.namprd21.prod.outlook.com
 ([fe80::9f51:f462:e8d2:d242%5]) with mapi id 15.20.6954.005; Thu, 26 Oct 2023
 21:04:46 +0000
From: Long Li <longli@microsoft.com>
To: Stephen Hemminger <stephen@networkplumber.org>, "longli@linuxonhyperv.com"
	<longli@linuxonhyperv.com>
CC: KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: RE: [PATCH] hv_netvsc: Mark VF as slave before exposing it to
 user-mode
Thread-Topic: [PATCH] hv_netvsc: Mark VF as slave before exposing it to
 user-mode
Thread-Index: AQHaB5W4U0Kx/aurvkOjV7lIJbHFdbBcSP+AgABHWaA=
Date: Thu, 26 Oct 2023 21:04:46 +0000
Message-ID:
 <MN0PR21MB32649DAC2B9A6CE863B320B1CEDDA@MN0PR21MB3264.namprd21.prod.outlook.com>
References: <1698274250-653-1-git-send-email-longli@linuxonhyperv.com>
 <20231026094719.04cace95@hermes.local>
In-Reply-To: <20231026094719.04cace95@hermes.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8f76e82a-7240-44a4-8a38-e096edef6efb;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-10-26T21:02:41Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR21MB3264:EE_|DM4PR21MB3440:EE_
x-ms-office365-filtering-correlation-id: 9b306999-15ac-43a9-e8e6-08dbd6672f32
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 xkYdZjGgg5BN/cC9oHbXKA7YFS+OPJIbSlGToagttNfWj18QMJl3Pf22vJfm22mUMNMXGT5D/fwy8GSg/944r9yzrTWJYAtiY2Te3/hWrDxGelG3bmEtN4wDNtLwUO7r6kfEgYJCB5Ygwzx1FQ73GOu8S2mrmc2SFUxoicSx4hFLn9Q9V3HY7HyFmeCxIbBW94Om2w3jfg1iuulI45ZawiVsILHFILahfLuGSeSr1M0lAlCwkovgUJUqxIdVwyDiH4244sY8sCUhtwgKutqXWCIUD5/bqPAn/KIqcMeaMvweRmER+vYDCXIYjhr+TgghT3LVUbtIbY/X3i0RCNXnj+TSMFA/FCgbkzqX/ft2b2d3JwK86HNrSfQpYcgnTbFZzlOhOleOzvyz16su+0VJRuIYuleKxB7JDdg6YCWA227Vcmhf5/3N94o9mRB6SrdufCwkKYk0upRFF3zzGvB2L/gjYTwOgd5j/cEtFkYDdYfQZqpnyB4bFoETVFtmHFK1H1TdG0DBIEorayvLQQhswTqWwn22NKEf6httvBVgua3GS6qTmkKa520kAVb0YYCibrPWR7M/zEUBBGPa/CUjw9uv5fSMHSnub84QMchSWorjA4NOr/5iODTc38LRdFRphEA/BbVmG3FRLQunERg5Fay9DuFs72fGOPvUVKXHs18=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR21MB3264.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(346002)(376002)(39860400002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(55016003)(71200400001)(7696005)(9686003)(6506007)(478600001)(10290500003)(66476007)(66556008)(38100700002)(33656002)(5660300002)(122000001)(82960400001)(86362001)(82950400001)(4744005)(41300700001)(7416002)(2906002)(66446008)(8990500004)(66946007)(76116006)(64756008)(83380400001)(26005)(38070700009)(316002)(52536014)(8676002)(110136005)(54906003)(4326008)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?4tFp36DBMufgm8HU8mAX2TUWoehcQp5sQPDYfhwszefvqGFWulnMKor4dsFh?=
 =?us-ascii?Q?RiWSPR30S+d0xuD9zjmQ/8l0VTzFxDGbMUzw7Ru9/bH438yBqxPFCheqZbiG?=
 =?us-ascii?Q?BqURibeEmnMjpyV5Zwr5+K0Kd5X+VdrRwYQjlDGYr8/w4HXjNdmWZriom8mI?=
 =?us-ascii?Q?6B92UYd7EspKSchYJkTwWRY+dfOa79TOHFPckCVNZB6bvNYGmkN70SmYkV/z?=
 =?us-ascii?Q?bumlJSlee6vhrPhtZ5ILdn3pTxAfQpKqY5hirjZBjPjl87Cn82OhsP/lpG4X?=
 =?us-ascii?Q?Ch/946RZNcbk/5cgiv5o/2yZuIL6qGB93SEL0/qYuz20rIxgfYnZZ8eEEKWK?=
 =?us-ascii?Q?4ObeTkVQolQcfv9s3rGsNVi0m3V155qn7GenMaU9k6Jl8E8Uy4nYetpF+dhF?=
 =?us-ascii?Q?My/KdlBmwwH+1ih30Gp0YzR70x5XeX71o6Z6lAB/uLpFmdruJyd+4qHyBui6?=
 =?us-ascii?Q?f8Dr8c2bZPZTmS2RmLiCMELAt47b/CzSYH8qRWiYJkKThQDEZI6xCsIZnySL?=
 =?us-ascii?Q?k1n6KzNoZbbYIMNCKV1heHHte0DDYLhVAvYsc7Mt1ML5Z7W36YDtL0wvkcx9?=
 =?us-ascii?Q?zUwYOpgF3iXM89wifOFAD4XePxmnOQzDYWP1x22Bz9tzRpevbtaS+bm2xzBj?=
 =?us-ascii?Q?Ch7KZ8wOsZZH5UibVbs0K9rPw80/lAsMMQOmALZSMkipRY68odXdRWMwu4YQ?=
 =?us-ascii?Q?CgArhn1OUzaXR9VWAAFR2jQzd8GUhOElXbiMCSRxbvJtBN727MrpIaflMU+C?=
 =?us-ascii?Q?7DGrLrZY9Hky3W03TN8BzvhRVZ3crvm7IHVc4fISDTw6EIMQ5FsrUO5cN+4B?=
 =?us-ascii?Q?6VDw3CrHhOQyNnoPt8ING9sHNffj784ydc7a7zwo2Mt/0vG3ncTN0H+S1aGR?=
 =?us-ascii?Q?pTlHKk9dvM9+03/Fp7slA+M/n3Bk5VTqn96ZGd/ngfwF+rxhmhYPfBMfmPcy?=
 =?us-ascii?Q?5M9i7+SE8Zohcc0xU8OXoOdwd0ZPV5J50VqP8v1RFZU2+nNNBw7McJ472r5F?=
 =?us-ascii?Q?9SEWBH7hRqce2QM/SMtg7QJIK1zAgU4B1Wf5CAwayR6A0ey5g4EZ8TJ3cGgT?=
 =?us-ascii?Q?OehR22lnEwcY8t/xUdPumT7xVPlud9UscqcHjoJjBmZjEBnPW9DnzJghF6y9?=
 =?us-ascii?Q?amaOkxLsMc+T1Vuckip4OxQaWu5Ob4nZygTULTDwgX40Bv8acTaqZcige8M5?=
 =?us-ascii?Q?chPfa5E3+sjWNVS229tMycAywfunbMO6YXO56SX/YxFfaPZYQqVtYcevSfYK?=
 =?us-ascii?Q?6GGQax0WCx42ZVmsWUUMDNFh9Ks44UyTRDauo2U0V303Lg4igTd8eM2n+TJy?=
 =?us-ascii?Q?TfE/3ys6XiJyBxtVe8+U1A7XTuqZCZ5CLyRQGmuozxy121xy5wOgOXXoyLjQ?=
 =?us-ascii?Q?/DJR1IORizmz7TMkmMFhWVhDNoNuKXIxUE8yUN5CoerrEEIYf93tbcpb5teY?=
 =?us-ascii?Q?XfBWHtHRL155hWlGL+WG0RLzVO6njhVAIFxKqbRY05f1l/oiazAIXLIu8yCP?=
 =?us-ascii?Q?SGuxmz1PznEzjEF/BtsA5skJTO2akYXuYGK2K7LpYqF2v2t32ouLV0nbgsLZ?=
 =?us-ascii?Q?ySZpW+HwUy004ccO7mtsuS8RyK+5fgj9/MPqSQeL?=
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
X-MS-Exchange-CrossTenant-AuthSource: MN0PR21MB3264.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b306999-15ac-43a9-e8e6-08dbd6672f32
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2023 21:04:46.4422
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vVJsWPo630wTRN5f4TZXN2KWPjm7cbaI6ljH3axYDyfARIlB2BTdaivoQZ9rXgIq5GLQdkeNmBTQRAhNO/8KKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3440

> Subject: Re: [PATCH] hv_netvsc: Mark VF as slave before exposing it to us=
er-mode
>=20
> On Wed, 25 Oct 2023 15:50:50 -0700
> longli@linuxonhyperv.com wrote:
>=20
> > 	list_for_each_entry(ndev_ctx, &netvsc_dev_list, list) {
> >  		ndev =3D hv_get_drvdata(ndev_ctx->device_ctx);
> > -		if (ether_addr_equal(vf_netdev->perm_addr, ndev->perm_addr))
> {
> > -			netdev_notice(vf_netdev,
> > -				      "falling back to mac addr based
> matching\n");
> > +		if (ether_addr_equal(vf_netdev->perm_addr, ndev->perm_addr)
> ||
> > +		    ether_addr_equal(vf_netdev->dev_addr, ndev->perm_addr))
>=20
> This part looks like unrelated change.
> The VF mac address shouldn't change, but if it did don't look at i.

At the time of NETDEV_POST_INIT, the perm_addr is not assigned yet (last it=
 was copied from dev_addr when device is registered).

