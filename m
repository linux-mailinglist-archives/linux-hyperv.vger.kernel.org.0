Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1A822D0645
	for <lists+linux-hyperv@lfdr.de>; Sun,  6 Dec 2020 18:23:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbgLFRX7 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 6 Dec 2020 12:23:59 -0500
Received: from mail-dm6nam10on2134.outbound.protection.outlook.com ([40.107.93.134]:49248
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726043AbgLFRX7 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 6 Dec 2020 12:23:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R3cAcXMVw9MProIRLKP9P3Ud1XRut5M6oVf7H++oc2/bMKMxPz1MxeZ1/stOp0bZm78ffqYGHZO+JIb1nLwUB/PM5LaZM/gAtyn9kgCNeQTFu7LIcvKLxT2RtBc0v9RSKhlZCfq34hymu2fImtGlLCot/Pmv8kzmuy8FfnUT1ywu1iR9mPybYxUP8RNypyh5Ry4UFaqNCFv29j2Ql4342pGzwTaxRR/y8MxZ5DdUKFxgMNwcaJmSsE6M310AaC+xGEC+iyZiZn9t5bpNoTJvSQ489Eu1EyFyTgmz7bxsTNdWRYGaLDseWby4Hi1AQKNoaGqtsZTIq7goJlyN8f92zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HqfsDvwkc7HkcAQFg8ab0iFWP+16//lyNu05Los+siU=;
 b=NM5ygoAi+dPvaTk/d/fA0k5MS7aV8hlYYEBYNNEZKGha3R8tMa4TSrYbKyTBmpJ7ynhABVsiAp/91U/K3WcT9c+QpB0lnN2g3f5RCx6ayRNaC/0nuPPdHcuoRFm6iAiaHLGh6OkQlF9JJsznAbT+QzawB57YnD0Knjyz9pXQ+RwH/f2aFUeEsXjnD9UyUZqKgaDF1dGHs2nTy7WGFwHlzg88G/Y5KreLirz5BFPYpZ5N1ViznKKDIpOA01yozf3qHUPOMpwhVOoyUl1Q69jThr19oPcihwgD5ykk8ay1vh6Ic/d4mGtplTiMx0FRavuPjLnWzE8C1pvnWFkfY/3Okg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HqfsDvwkc7HkcAQFg8ab0iFWP+16//lyNu05Los+siU=;
 b=NBwRel+EsDImE2BQ0YC66s6P5or7Cyco+BRZ5KO2iJceijE5/NiK7QU+Ye1XmY4y6bECXt6OHhVxkXBNePOmkId99ANgjb/wbbLQiz7dK43boOCtevgUctS/v+rAPQhskTmP9lWRU1GoMapBawfeoMtOAIscOElqF5jKetISm4M=
Received: from (2603:10b6:302:a::16) by
 MW4PR21MB1857.namprd21.prod.outlook.com (2603:10b6:303:74::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.3; Sun, 6 Dec 2020 17:23:10 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::b8f6:e748:cdf2:1922]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::b8f6:e748:cdf2:1922%8]) with mapi id 15.20.3654.005; Sun, 6 Dec 2020
 17:23:10 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Juan Vazquez <juvazq@microsoft.com>,
        Saruhan Karademir <skarade@microsoft.com>
Subject: RE: [PATCH 4/6] Drivers: hv: vmbus: Avoid use-after-free in
 vmbus_onoffer_rescind()
Thread-Topic: [PATCH 4/6] Drivers: hv: vmbus: Avoid use-after-free in
 vmbus_onoffer_rescind()
Thread-Index: AQHWvbhjgRCg8KMPF0yaT9Fglskz7anqa5Yw
Date:   Sun, 6 Dec 2020 17:23:10 +0000
Message-ID: <MW2PR2101MB1052402E702FC16A342E048FD7CF1@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20201118143649.108465-1-parri.andrea@gmail.com>
 <20201118143649.108465-5-parri.andrea@gmail.com>
In-Reply-To: <20201118143649.108465-5-parri.andrea@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-12-06T17:23:09Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=7d2bc284-f087-4eae-acf8-6e9af3225b69;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 42b23caf-aefd-4d00-4d25-08d89a0b9af0
x-ms-traffictypediagnostic: MW4PR21MB1857:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW4PR21MB18571FE468D07167CB3F66FDD7CF1@MW4PR21MB1857.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1775;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V2TZnBQSPX37kQ3Vl/VCSljXydYUV0/m45wVStxBSaLBYz518b+H0iVo8CysQci2poCofihsrPUJ7CkiX+6PVWX74fF0cHFCnwCHdAc7MNFsyCASjJ5fsGbCfP/tmnu1R4BFRxM5JjFeaO2uD1i/V5qYy6vmeJ9npoh8F2VyeWLZx3RQ14Wm33xp0vzY28r1Jzu3DUtJ9kmYWs3sxtJgsAXBoo3zqokpVXZ8Ac9k/fXxoSkEWD5bz+d9lNClu8VCmkrvmFF8PADeug+JHIm6ek1L4XuL7zH5gMU/klelIXya9ajvvmvW0AamZFkEA9vKwW++d8TT0OLB3hvBlW/CGA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(396003)(376002)(366004)(136003)(8990500004)(83380400001)(10290500003)(52536014)(478600001)(33656002)(66556008)(26005)(2906002)(82960400001)(55016002)(7696005)(66446008)(9686003)(4326008)(8936002)(110136005)(66476007)(54906003)(6506007)(71200400001)(107886003)(82950400001)(316002)(64756008)(66946007)(5660300002)(186003)(76116006)(8676002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?1qq0wf1gN+y5/zV0MYolkPtm8srwGhebespJT+JeoKoHgpZFTvhaMxZiZvab?=
 =?us-ascii?Q?VIwkxGfJ93iA/sqkrMLS/VVME37D9q5eBm4YWSWArm9En8puOvvKKScCaNcX?=
 =?us-ascii?Q?4BWUAsdH8/awkEf7uWzxyUWzwNx+s5WOTxcISSPvu18iaUXKp6kf9DB3hS6y?=
 =?us-ascii?Q?1mVqsawmgAVZEmZUQUZJXzbgFfi3niB/hIk4xBGlpkxr6e7Iop120PW8KIFt?=
 =?us-ascii?Q?J3QPOnCwXukwrbZgVq7Bej3w1djqFnvLlzyj2bdOvV8Uk0XNJj3UWDJfBQhS?=
 =?us-ascii?Q?Iwd6R3SKED7eVJlsGl9hM6IZ330PIkpeI86up3D/qmawdDmSwKijGuFqkmg2?=
 =?us-ascii?Q?6n040keRFTjK0swpnwRYk5/t+VDpLdjscCGY3aNIjXzu75iwz0cC6RrhFJfT?=
 =?us-ascii?Q?eM5WJhpmAEzP93I6V2uYZMERutFRrzmYelkQyPcSONdd0aBOlx4N+ItCXxPa?=
 =?us-ascii?Q?O6bzazB4v8Lceqt2Dsq9py1y+kkJuC4fqf9tLnAFS2K6nTwJqrcG89xyY0nr?=
 =?us-ascii?Q?5G2dlykkeA+k6w55VtaaHOiedrVoNPIggwMG8XATys81N76aILRBSBRZcEBl?=
 =?us-ascii?Q?fYqd8zMgx196/SJHMLBgsXgWQrBpI7OhbMvDAnPvkSlALNNxP1UDYIGI8JbV?=
 =?us-ascii?Q?5W+I32Hrce5F91z0e04B3tsaVu/f7K5OVh/F2bMIqGM/Skf9CbECDyl52JOR?=
 =?us-ascii?Q?YAx1ba6N1JhFzi0qvRJk59OSzPUkvi81BpZ2YEaFlNjq/rdsmcsgAWq2mkBB?=
 =?us-ascii?Q?8iRVEvopVUsB9yzXkYZlnGmYDhgaVU1DITpDc2sb0nfK2QAXgrveQdXkArqy?=
 =?us-ascii?Q?66o65dHYlBkRR9UatAb1cB4HjVd4n69CvUD/lSn/rM+lqgD7R8w7tFC9Bim7?=
 =?us-ascii?Q?oW+XeybYhOF6BdB1PaENAOSUCZ/otLWBukSws/c0xJ9Mo73xf5OXxLtwI+VR?=
 =?us-ascii?Q?NYvHpgiivUmSSO3dNdbOcxj2az2+3kyTPuRhVS7aIr4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB1052.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42b23caf-aefd-4d00-4d25-08d89a0b9af0
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2020 17:23:10.6563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BJwN6hXVTQBTpf9anA8/juUlWxHZqjnIQUFag/OE58RY35lRk9kwBwt4gRawMXL1sVATd7gSCYxPYdzkdU1REtVbd8DdDWN2uX6mpeY+FlU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1857
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Andrea Parri (Microsoft) <parri.andrea@gmail.com> Sent: Wednesday, No=
vember 18, 2020 6:37 AM
>=20
> When channel->device_obj is non-NULL, vmbus_onoffer_rescind() could
> invoke put_device(), that will eventually release the device and free
> the channel object (cf. vmbus_device_release()).  However, a pointer
> to the object is dereferenced again later to load the primary_channel.
> The use-after-free can be avoided by noticing that this load/check is
> redundant if device_obk is non-NULL: primary_channel must be NULL if
> device_obj is non-NULL, cf. vmbus_add_channel_work().
>=20
> Reported-by: Juan Vazquez <juvazq@microsoft.com>
> Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> ---
>  drivers/hv/channel_mgmt.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
> index 5bc5eef5da159..4072fd1f22146 100644
> --- a/drivers/hv/channel_mgmt.c
> +++ b/drivers/hv/channel_mgmt.c
> @@ -1116,8 +1116,7 @@ static void vmbus_onoffer_rescind(struct
> vmbus_channel_message_header *hdr)
>  			vmbus_device_unregister(channel->device_obj);
>  			put_device(dev);
>  		}
> -	}
> -	if (channel->primary_channel !=3D NULL) {
> +	} else if (channel->primary_channel !=3D NULL) {
>  		/*
>  		 * Sub-channel is being rescinded. Following is the channel
>  		 * close sequence when initiated from the driveri (refer to
> --
> 2.25.1

Taking into the account the separate comments from Wei Liu,

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
