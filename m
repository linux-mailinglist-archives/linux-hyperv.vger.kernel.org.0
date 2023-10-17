Return-Path: <linux-hyperv+bounces-544-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDACA7CC9B4
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Oct 2023 19:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72E32281A00
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Oct 2023 17:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16DA2436B4;
	Tue, 17 Oct 2023 17:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="atjvaYgd"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5042D028
	for <linux-hyperv@vger.kernel.org>; Tue, 17 Oct 2023 17:19:44 +0000 (UTC)
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020025.outbound.protection.outlook.com [52.101.61.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48338A4;
	Tue, 17 Oct 2023 10:19:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VW5/T5vOpnWpOFfiUrmUJ5fa+VY97au//5xg7eAAKCMBz2mm6W6ZxuyWicVInUzZhq6t39MLXV1GsvzwnAGPi48EZ8Yn6h7JPwUTosSVBz41bRVMPSZRrB8RkfKRWaRf8JLmSDAbC4rd8JFcFVKJi6m2ZNMalKuj7l0bxffRcLKKQB4f8eRVhQ3o8TjTg42I1EYXBlk54BTnjrkAlgYssTlDOav3EjDOf5adeX7RQ43tDtaiboOuUxtGCL2DRIBUekO1VZD7eZHK/KRt1Tf0iN2BZ0o3Wxyyef/UlUZLvJY0KInw/2Fye7KEUH7BYuDkMEWogAvivipW4kiIYEUaZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QDyC6aUdLlBAvPOEX5XG+BQIs8+2oLf+pzhRkxuOmRk=;
 b=ZDHNn7j4TbcZgnbG4h5m4/dB8muUTww3l0hDDC9dEJ5W6UobZgWL3DXyzMKf0Wlr0xVMEjKe5YEyZ+j2meai6lhBVG0hF7DYMiuCtmu89gkj7C5JaLtgq13SEdtTpfEMoQ+xxcxEkKZKENfGcX3zZB+s8uHx+2LFF/erCnMVOK2tVPTq4yZHsmZvt1OTIic9/7+4Bo4EDt5x6ZQxMX0mmoYZg8uXI+CVqgXGgMWH58pnmnYcPokH0glgIT0pRSPP3pFPvGIrPrQcr5Y53rGDjttPWHOvxrS3fxCyZpOpywUEFwuDC+kj0ESbi7obQv/JIokP12x3uxhnauNjNNOWuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QDyC6aUdLlBAvPOEX5XG+BQIs8+2oLf+pzhRkxuOmRk=;
 b=atjvaYgd8jnkQ6EjYzEdcD4mfWp2Cx8zXYvbA2sZaz4lOXFZt+rfAJ/r9+H59c3P0eDNcRgCyra1ZHH4ZDkkxHHccusjQ9H3He47X9BZEuikOrrU3ZVf0ZbsVi/wIfSlqnU6JONgqIIqZSApat119xPAUlUs7iqYI4Rn91m7Bn0=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by MN0PR21MB3703.namprd21.prod.outlook.com (2603:10b6:208:3d2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.4; Tue, 17 Oct
 2023 17:19:39 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::4592:a0bb:e4ef:3093]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::4592:a0bb:e4ef:3093%5]) with mapi id 15.20.6933.004; Tue, 17 Oct 2023
 17:19:38 +0000
From: "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To: vkuznets <vkuznets@redhat.com>, Angelina Vu
	<angelinavu@linux.microsoft.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>
CC: KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Subject: RE: [PATCH] hv_balloon: Add module parameter to configure balloon
 floor value
Thread-Topic: [PATCH] hv_balloon: Add module parameter to configure balloon
 floor value
Thread-Index: AQHZ+8vbV3zwHLnGYkiL1+0l9vLIfLBOGFyAgAArDVA=
Date: Tue, 17 Oct 2023 17:19:37 +0000
Message-ID:
 <BYAPR21MB1688AD7F27C9CA40F7FB4EF1D7D6A@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1696978087-4421-1-git-send-email-angelinavu@linux.microsoft.com>
 <87jzrl71me.fsf@redhat.com>
In-Reply-To: <87jzrl71me.fsf@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=ce22d28b-a4cf-468a-9fb3-2bbe714810d7;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-10-17T17:15:18Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|MN0PR21MB3703:EE_
x-ms-office365-filtering-correlation-id: 83cdc12d-a9f4-4cf9-46ce-08dbcf353dc0
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 EdloCRCLs39s6sfvmd0QZgkvcmdndlN0h65ICNtbDQIwzJuo3Gbx2DdwAVzKsRwXpUwhrCX1qdgvw+C5sI+MLyKyiAM8542SZTnESvloaeghz6mKmB+MdwPmKxmaXeWWhphm2dvY3VhxyrxX5ka1m0GamY+RWQ7pIvyk7GRldZTuP4khlopZObGSmA/EM0Sw2/gLWjz1AM/d5lO4NyDxVN63OivGMRNOV8NNZAf1bwOZDqcp+qZJ4YUJRcJ7U0aYQyBA1az/aRA3GJFnNrRvVkehIptOckDw67GsIGHmWRTsGYKisA0g/EzYHy0mVGZFQYNlOLEKMe/Ob6thIjTZDxYFqNraY76r5+cPbsE7iaqPxi+/eNXsuM06gYWBymrs9gvOYdhOHHCrnJwscpRk9oXde4phu8kbcJglsJwxk0CulM24SZY8AuQ9yr8KdhVqNhhWZZOSMhbJ/lAJN5yKp6Z1dsubVJPFjIK8moLDrCOrEiCpwtWmiKLzVHsLL1arkV/7EEEOoe8c6bMHV6Gen8IjPMvJ7S7neJYknv8G5sm2trJlTLFwbGftdaD0D+oGEBHx5c7n+uPP/OwX2/eTSnKzdNumgNsLf0V2cifIaCVWGtoT537wy8sdIyol2QRjq0JAl9VuOpJOs17gcfLpe5HBmpXw62KiIVWZQbpxkbo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(366004)(376002)(39860400002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(82960400001)(26005)(83380400001)(82950400001)(41300700001)(38070700005)(107886003)(122000001)(33656002)(8990500004)(9686003)(86362001)(38100700002)(1700900015)(2906002)(7696005)(6506007)(71200400001)(10290500003)(55016003)(52536014)(5660300002)(76116006)(64756008)(54906003)(66556008)(110136005)(66946007)(66446008)(66476007)(316002)(8936002)(478600001)(4326008)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?94lB2CIiN0yPmWPuSXGkxggmz7yr5V1oiyQvo0rBjaBKfsyLYuM5K42WIJLn?=
 =?us-ascii?Q?j4icLZDdvvD/kS87WR9QykPzixgAI4zcMHvBkaLfZqfMoaSVgmIh3yq5qXl4?=
 =?us-ascii?Q?6IA/mmiqRwCOV0JXkpzEBtG6ZfyYWEMk0Yr3a77dytksgS/l3wM0zS0Ecdbq?=
 =?us-ascii?Q?vPX9G9kD/rji4MpLN3fImaq5KlpwKThc2g+6aq0EUSN97VkEkBDqTlbkutcn?=
 =?us-ascii?Q?BESRisAjYxyJLrD80kHb9o451qD1vn0xZ/75MDMCXPCUBXAksr/sQzxPYHe+?=
 =?us-ascii?Q?VClEm3XP3yT1t25slfoBJ/4f0jSQiaQ3xUsR6HaNHce55hW7eFzbEGImaEzl?=
 =?us-ascii?Q?OR7Lg1MG8uwXAaMO/kOpQd4ABtcXzecZd3Sr8iPLJLpq4zM7+KjMoE8DcdTU?=
 =?us-ascii?Q?r/ofyaKKLzMqdvFUPxaP/726oE4Bm8keG5MGtEzni6p3oK84gzuaW8P2eIDg?=
 =?us-ascii?Q?nefmGwJ3chGBpsD/1Yb8ZAgXdMgB7nZduqNDTrXrNo4igduJ73vEwgxlUDNW?=
 =?us-ascii?Q?8U7AOp7PmaNMnpEjIeRshCLxpkjtB1i13h1eV8c0qfUX0n22tNoWovubzcKJ?=
 =?us-ascii?Q?eNbgM13H4sXaegSuHyK6LLtY3v5OzliS3PgXcrynQMT1cI6rj8ca2ttVcwV+?=
 =?us-ascii?Q?JjyGLExjI7V8zLj+u5BEIBGOGyNI9CHtR1SA+rsxdsfJJuv7oAAetmIdgLXe?=
 =?us-ascii?Q?EHSCqNpfMTCt4lqltKX2E5cMwMfszwAN/u//o0Qa95ceWk3JZVLf9Xl5k9Cm?=
 =?us-ascii?Q?BVyRPdj4wjWoQijBEh6j63QpAsReVNS3mfGu6vunbJDj+G66YB6i2m48Zx+i?=
 =?us-ascii?Q?Qv1chPmSksnFsrFf9PAdjwUTdwL0etBTZnu1VSnpb4qJPNExAY/EZcX12Fsd?=
 =?us-ascii?Q?FBI8M40V0foCLtRGSuD/UWZhCzVGFX6FtWbFF2tmTHp/gZTP6Q+jLRhNIfZV?=
 =?us-ascii?Q?FCMdh6xe8NGieBH3XyTINb1VqzCuu0iCEYZNeXJHA3bWKi8WHoanQW6HLorB?=
 =?us-ascii?Q?06kJpMsn0ru9VZ0WDC7oirKcreGDsGmuMzAsI3ZNf+AVM+OS8CqvaVErwpY2?=
 =?us-ascii?Q?HkdNMkjgJHLMtA3Og7askev6zDXOSzQsGUHDlr7pqjAgrFS6+JRTOFzqHKcA?=
 =?us-ascii?Q?0Av/feVtSjpxBUYYGJVhLhQonsP24bVHdnw3nuqcmStbRXtuYDbP19n3V9mW?=
 =?us-ascii?Q?butaO9P5M8FFbanM6QLLcVv4bsCJnaI9+2DjlxNqQqPkfygpHD+SHZ3ixb83?=
 =?us-ascii?Q?ErKBaFJXdC8NvCkDTxNckfkojX6Vl6k5KuvY02qgYsiUSFDVPtmNyBsVteZx?=
 =?us-ascii?Q?0Mzw1dn2MujEp+fFGDGTbAfp5ewgNrSUVinceSCM8wkVv/VL8NnMjn9GgZ2g?=
 =?us-ascii?Q?4i/Rx4EwSsiZQKFNDZzrLgLWDY5hBYTvvcldaK/icDqiAIQZN5N3DUay8+lP?=
 =?us-ascii?Q?n1ytXUpt6fEnuofYMHWNrI8t1P1Y5tH+6jMJ3E5RpTBGu9aZron1Crg0g7QC?=
 =?us-ascii?Q?NADDF/qSJdv7JvOjzH+NmuchyceefVMYprI64ue55OaHSFynCk01IGHpU23R?=
 =?us-ascii?Q?FaRFpttAJYBrMxiRLIVFIeJUk7YVJiNxiFi+ho7NEitH+20uR9oQ/ZDdxAS6?=
 =?us-ascii?Q?0Q=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83cdc12d-a9f4-4cf9-46ce-08dbcf353dc0
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2023 17:19:37.8992
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3eDzd7Ai7monKdyTp3PBW08N05kAJy5NrFAZrpwiopDJ7Tp78styrnAuTpX+sAYG2YJ/Yzn3eBubIBX428a2GFSzbnZrV1vLcg0RTPmMzNY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR21MB3703
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Vitaly Kuznetsov <vkuznets@redhat.com> Sent: Tuesday, October 17, 202=
3 7:41 AM
>=20
> Angelina Vu <angelinavu@linux.microsoft.com> writes:
>=20
> > Currently, the balloon floor value is automatically computed, but may b=
e
> > too small depending on app usage of memory. This patch adds a balloon_f=
loor
> > value as a module parameter that can be used to manually configure the
> > balloon floor value.
> >
> > Signed-off-by: Angelina Vu <angelinavu@linux.microsoft.com>
> > ---
> >  drivers/hv/hv_balloon.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
> > index 64ac5bdee3a6..87b312f99b2e 100644
> > --- a/drivers/hv/hv_balloon.c
> > +++ b/drivers/hv/hv_balloon.c
> > @@ -1101,6 +1101,10 @@ static void process_info(struct hv_dynmem_device=
 *dm,
> struct dm_info_msg *msg)
> >  	}
> >  }
> >
> > +unsigned long balloon_floor;
> > +module_param(balloon_floor, ulong, 0644);
> > +MODULE_PARM_DESC(balloon_floor, "Memory level (in megabytes) that ball=
ooning
> will not remove");
> > +
> >  static unsigned long compute_balloon_floor(void)
> >  {
> >  	unsigned long min_pages;
> > @@ -1117,6 +1121,9 @@ static unsigned long compute_balloon_floor(void)
> >  	 *    8192       744    (1/16)
> >  	 *   32768      1512	(1/32)
> >  	 */
> > +	if (balloon_floor)
> > +		return MB2PAGES(balloon_floor);
> > +
> >  	if (nr_pages < MB2PAGES(128))
> >  		min_pages =3D MB2PAGES(8) + (nr_pages >> 1);
> >  	else if (nr_pages < MB2PAGES(512))
>=20
> A module parameter is probably useful for debugging but it can hardly be
> applied in production environments as it must be 'one size fits all' and
> e.g. for different VM sizes it can be different (that's the purpose of
> compute_balloon_floor() heuristics).
>=20
> In fact, does it has to be statically set? Can we have a sysfs entity so
> this can be a policy (userspace decision)? We can keep the current
> compute_balloon_floor() as the default but users will be able to adjust
> accordingly.
>=20

The module parameter can also be set or changed at runtime via
/sys/module/balloon/parameters/balloon_floor.  Changes made by
writing to that path are immediately reflected in the value of
the balloon_floor variable.  I think that accomplishes everything
you've outlined while also allowing a value to be set on the
kernel boot line.

Michael

