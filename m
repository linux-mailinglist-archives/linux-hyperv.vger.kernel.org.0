Return-Path: <linux-hyperv+bounces-691-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 272897E0B3C
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Nov 2023 23:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0D4EB2157B
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Nov 2023 22:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBABA249E0;
	Fri,  3 Nov 2023 22:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="i7jyLPbP"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4428C24A04;
	Fri,  3 Nov 2023 22:44:14 +0000 (UTC)
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021006.outbound.protection.outlook.com [52.101.56.6])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E766D70;
	Fri,  3 Nov 2023 15:44:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oOfoyObKiQ1mSjpVmF1M3fhq3/N11lUuj7qtwA44WYmsXSJF24TSXocqlrL9AwzGZkmFvR4ZMaXJDlMtdkKV6sIDEvP4DKAJ5rligdlxgQeC7dQCU4YkXbmEWkcDbxTGbLRm6cEt9uU2IFVwumY7vdf8gTIiOjmuNcc8cXIZ3M/HAy8Q2Yec6AkvB7pmB5jZYNCMuR/suMsjcBuzWzI8vGxihEGFHlEhu/qwZ4OQ4a25WntI0A/GzH9Drv3uJbxeUxsHJRMAsvYGayuoq/dvsfATC1kzlUWwHdeDfSP9pxEjz0o8+TVP4X6eEJCbM7OpmL4Y7Wb2XrzPouOQXzNQTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Do1Inb4Bg6HrjIawh4HzgXg/Lz/WMuJnWCLyN7kHpXE=;
 b=lziLRzE4gTo1H3Gk/duRQG3qqFJSTg53C8QnbXKaG3Y9q9CQQNWqjWGo7pTe928CRt0oRYO16j20nMoaC2NRzce8LXByHaI2j72Tlzs53rYe/YpNFTRBZ8VW5MsfLgyAhP2GcOsoSuPaTFrfoLNaWIgXDD1EmarabkiRlzy9GUC/L2HnuYQ0NZqYM2VZ/tArsK8GbF7o9sSy5QLTCDWnmZHCsCtsHfbLHs42DhDzjj0NHt2D0hW/BsBDiohisvBv85rLxl4AAV/n+vzOvV14v08we+YgzPku7beNavaNYaYQ4Y7Kn7MMCqnt1xbuGnLZxZOuFCZfxKRdDQagWo1cAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Do1Inb4Bg6HrjIawh4HzgXg/Lz/WMuJnWCLyN7kHpXE=;
 b=i7jyLPbPiYP5476WDkDCmHu5FFpHZKmCkEcGGd0JSwYleIBXEfK08rOd59mBS9Wy1Fgdndt4DY86apbpLoIIiCpBhU9WrUBtkgxzeO0aixapYfzO5H0BvE9GWtVcTTW8hwmf6N+lVRPXVDw61vJDRQtYrEv7jucRLny056hOL2I=
Received: from PH7PR21MB3116.namprd21.prod.outlook.com (2603:10b6:510:1d0::10)
 by CY5PR21MB3444.namprd21.prod.outlook.com (2603:10b6:930:f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.12; Fri, 3 Nov
 2023 22:44:09 +0000
Received: from PH7PR21MB3116.namprd21.prod.outlook.com
 ([fe80::b0b2:906f:67fe:322a]) by PH7PR21MB3116.namprd21.prod.outlook.com
 ([fe80::b0b2:906f:67fe:322a%5]) with mapi id 15.20.6977.012; Fri, 3 Nov 2023
 22:44:09 +0000
From: Haiyang Zhang <haiyangz@microsoft.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, KY Srinivasan
	<kys@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH net,v2] hv_netvsc: fix race of netvsc and VF
 register_netdevice
Thread-Topic: [PATCH net,v2] hv_netvsc: fix race of netvsc and VF
 register_netdevice
Thread-Index: AQHaCFKpKET2UnWjhkeRl4AacA94KLBmhFAAgAK2PJA=
Date: Fri, 3 Nov 2023 22:44:08 +0000
Message-ID:
 <PH7PR21MB31169E4E03163358946BF95DCAA5A@PH7PR21MB3116.namprd21.prod.outlook.com>
References: <1698355354-12869-1-git-send-email-haiyangz@microsoft.com>
 <20231101220730.2b7cc7d1@kernel.org>
In-Reply-To: <20231101220730.2b7cc7d1@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=c223206b-d339-4527-8658-b770b1fdaf94;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-11-03T22:32:15Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR21MB3116:EE_|CY5PR21MB3444:EE_
x-ms-office365-filtering-correlation-id: 79e540b1-2ec0-465e-f8a1-08dbdcbe646f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 is2tu15sa+OqzXChbJrl6nuXGXlZaX+fIGTOsPEkSRzIfYsxmna7IDYl+4FdYOlXhbbz2vNVj4Wi9C19lNqlM7VIWTxtEzgRh6cXfxysSKZf6lWsHoAvZdrOqx5jK1U1rWEGZeZOiIAoHBVTXmU3vStqL7YEoZvRTlFF78lic7Z6bece5vbVRqIw6bgH6xTflu7pLLo3u0/puHZFeTnuNaAaBJP5AtWg8Vyv1f91o9VvfkFLQvtvSCn6yyZ9oEAAMW+DPSd9vx8SFwsG6C8N8yILjxVRX1Toe9NfUKuFSFcLYKUhN5uhG3mbxXRTJUnyeY3YW5+tbxgIajdKYTqgRQrEQQ7TZdjBPz3ffXmW8teioBiq1xCuSG8OXmk46MuUI5UeUML6UlzC/r1G9t89PCIlgZwiuCykb8+h8jFAKaN4at8dTKC98HWXa3DeN1lSW+1tS6My+XPrdUpWwtF9ZL5erDX9lWTPM0yw4udvnVQKBaR6Zh2Bceviaa8ZIRaV/yCx0pxYxnr1L4HH563j5etptQqP47y0cJQmIkyEUa9xfLDrnhtrKPa1FzJuijXZ3UdgGNC/ibNWlt8ivyzyBZcaFphbOSXaOQeTse2yPt1N+6ztIaRwul7TBM15GNANsp3s2uVB0PueLFZIMzfYy8npm61Z4HyDt0HQc1U+XNM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR21MB3116.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(39860400002)(366004)(396003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(54906003)(82950400001)(66476007)(64756008)(66446008)(66556008)(82960400001)(66946007)(122000001)(316002)(38070700009)(6916009)(76116006)(26005)(10290500003)(6506007)(7696005)(71200400001)(478600001)(53546011)(9686003)(38100700002)(86362001)(2906002)(5660300002)(8990500004)(52536014)(41300700001)(33656002)(8936002)(8676002)(4326008)(83380400001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?7hf7yvdDH9fg8kC/+EMP9aZscZYkCHAGVA9uRIz/52umhQlA06zpC0YINi4K?=
 =?us-ascii?Q?Nu9anYXXbXgF3kWxxxjIIyB8SAZfqW3i4FDLCNbY0kajm5HPtFOIoncT0lKt?=
 =?us-ascii?Q?ofhl/4IZmcWXDW5rdrsKn6YnZUpaulqT4O0lsM9PuCuNC6cT4z3yH3lHAIKZ?=
 =?us-ascii?Q?2uIKedeusyJzZxdYWMn0vDrsddsd0zpuJDsYaXd8fg07QpD42aiK9d4VXAjG?=
 =?us-ascii?Q?9gxYUjdonU37OcycJh20tJExXuya8RDpB2JQq4YZ4hj3AoZplwM7Hlkkgdzv?=
 =?us-ascii?Q?FlGF+g5EUywP4ROWDi3jzOFFi5mOXfWlrH0QzwENGB1+7sB0x9fK+Dt/fy7X?=
 =?us-ascii?Q?WtwDXg52pKue4WOb47otx8tCo3caBGjNgyLbXazqWc3k+B/JMDcK9zeTwYY/?=
 =?us-ascii?Q?XQvrRfzwyWy08b660HZr9gEt8miizPd0Z2VdQTRclQsgiAn+ox6cufJJGifO?=
 =?us-ascii?Q?aL+oy/a+9GxvVCXumEKtv4AVTRackaoQLHSyNAHh+UFElkAlaZsHju5hOrxm?=
 =?us-ascii?Q?0+ALC8K4PisA9LQzAWesBIcPeSTXL4ct+F5sSEY2vd/r71NRtE0MkY8kWy16?=
 =?us-ascii?Q?eIHQBVOLdmZ2EDp+4dadaCiczTaUfsdebagzUOdnOeXCPdGcQqsOQ+Rh0wAd?=
 =?us-ascii?Q?75wflIPX2imA0Yyo4o0o9NMgzg4cs44inuqgNL2hQBM7CSwSXdRaRgF5EimK?=
 =?us-ascii?Q?Tpr65Z8jGk4DUxgVtr36uDUlDYpy1XotKaFfck3qKd86fTua/4jvwjPqObwP?=
 =?us-ascii?Q?P112FdJnpkyyeSIYKVLAZg0EIF9waYGcoXixi+avfB1HnTrc7MgFjaRlxfb8?=
 =?us-ascii?Q?0WZqLuOmIP5ihYIZ2ktTq954GGwSKx45/pRgEyZ7RnupIdw2xCIO9u+PTWc6?=
 =?us-ascii?Q?hEGK4N2GsTVnadHG8cyWJRORZWEVWFvYDzSjPw6ODcEleD432hdBSlmvHZ7y?=
 =?us-ascii?Q?8snXYAzfHGYbDYuQTC2rHSmmQX3O1ixXGnV79mUKukjDsoy8/p7yk9//XYBF?=
 =?us-ascii?Q?Q0uUooSQeov5Ly8zdwGS446+VVyTEOpD7HYmf2wYZT2scJmTBs1shErFx/QO?=
 =?us-ascii?Q?ExPkoqe2LYIjrV5LGzXw5b5n0yhMMMGo3+qPPWeY1mydnz7pbO+E9t/2A4DV?=
 =?us-ascii?Q?bFN231MQPnZHIYtRrYlK4aMl+BONwPcAMW5w2rWzVo1/DAl3BC9qvAmiO/el?=
 =?us-ascii?Q?u6WFsEVNtjcdfZTmw/4ZEfHxuPNbB5VqqgM+jHusLOwUr/mJiqjt7k5aJBO9?=
 =?us-ascii?Q?1ZkbOhNgg4/BYnl5BroxSznblgZIAHHoPvlps/aG5Spp/F1YM4ONrjHcGyYa?=
 =?us-ascii?Q?GZd4oOkw8vTBXmb1Ojv9zeue1vfb79HBZlgU4gag+eIxplF+/SRpsBIcy34t?=
 =?us-ascii?Q?8oHRb7gCXUMSJTE+akVFZN56J/u2bEfSwOnLhRAD2pJkriAqFqblStJP7p11?=
 =?us-ascii?Q?UepG0yqEG7O++J5Jg6FGgTPLyMOrCTM95jwZDrr4dCVcoTNtKN4rTUZUSooW?=
 =?us-ascii?Q?OSDYqjA/gTsS3fmQcslOn0Rv/mHXUxGFK7TMH71X5ZX154kjmQ1WVjhe/HdZ?=
 =?us-ascii?Q?OiEctZ3p0FLIl2Q4k9OSMhXwi++2b0xM8w2TkH5z?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH7PR21MB3116.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79e540b1-2ec0-465e-f8a1-08dbdcbe646f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2023 22:44:08.9736
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3qX3ixAhQT1dYm6kr3zF5SdQPwtkrGPM26GILihen/FLlAa5xLHyqzuJ3pUufABQJqKSFsNkbaJ/3NiR25FY7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR21MB3444



> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Thursday, November 2, 2023 1:08 AM
> To: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: linux-hyperv@vger.kernel.org; netdev@vger.kernel.org; KY Srinivasan
> <kys@microsoft.com>; wei.liu@kernel.org; Dexuan Cui
> <decui@microsoft.com>; edumazet@google.com; pabeni@redhat.com;
> davem@davemloft.net; linux-kernel@vger.kernel.org; stable@vger.kernel.org
> Subject: Re: [PATCH net,v2] hv_netvsc: fix race of netvsc and VF
> register_netdevice
>=20
> On Thu, 26 Oct 2023 14:22:34 -0700 Haiyang Zhang wrote:
> > And, move register_netdevice_notifier() earlier, so the call back
> > function is set before probing.
>=20
> Are you sure you need this? I thought the netdev notifier "replays"
> registration events (i.e. sends "fake" events for already present
> netdevs).
>=20
> If I'm wrong this should still be a separate patch from the rtnl
> reorder.

I tested, NETDEV_REGISTER is indeed replayed, but NETDEV_POST_INIT=20
is not.  And we will use NETDEV_POST_INIT soon.

Also, we want to get notified by NETDEV_POST_INIT immediately from=20
VF, before VF NIC shows up to upper layers. So, even if we make=20
NETDEV_POST_INIT to be replayed, that may be too late.

I will put the register_netdevice_notifier() change to a separate patch.

Thanks,
- Haiyang


