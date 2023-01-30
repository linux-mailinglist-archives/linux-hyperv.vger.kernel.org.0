Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F9F6809D9
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Jan 2023 10:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjA3Jrg (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 30 Jan 2023 04:47:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232072AbjA3Jrf (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 30 Jan 2023 04:47:35 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2111.outbound.protection.outlook.com [40.107.96.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4D81630E;
        Mon, 30 Jan 2023 01:47:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KLHU0IOEpL/AnxRfV+pxG7oFf+TXMu2Lk1HaHML6KnDcJQBJhaWCJTDbHzYGCEEnF8MPJTryiOr2uYQAYxP3jwsTMPiq4U+H8uUCjwTWJpjlWiiBNb0CkF1ITHqx9s7BLxU/57XiP1e6TwptEpj0SxV99yetxP7BcIIiMEL8G7RZqzcpRlDCNHzZ6c9ToTOqUPHiAWpIXQMu9b6zyMi36+6LCMMsejNqpxiwtexF9FknO0PC5HImUl5bNcG+UM3EUlQlwk9Snxw8M0gU7E95slur7fRgqdfEMPT2T+oskX7i4Y5ZkvYuxTxg5XFX1vik66gaF+pvCXSFM8mbtvLMEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g8RSX86VyDnH9ItC2Mxl0P1Rlt8GEvsqQz0qmm13kPA=;
 b=UlVyQu50K+qg3ejwHi2u6lX23i2ZVtrcrBteSzUc/He1tHKdi8ySXBQudLwDxNC8N3jQsBuivPZ+n5V4TEFR/++XnFVFwGM/clsIdcdXp+ufsYjNvTd11kPygTF9eSdh+p3Js5lSbg8pcdL0B2yh5jSlAtOWL6qcaa1lGy3mHxUjdVrdDe0w/i4XsE1i6seWi9e0ov+462N97yfLl2D8XjMG6VPzdp8z2YRe6j5V07LYPAZBd0ZHv81/aYSdCCWWjV/M2t9uXhSI3gZHtrryJftebSfhKu1NzL1gOdjJZ4a2FplOvKSDtAsDdejrOmhPhhIahsmVxRvTW+APhajQLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g8RSX86VyDnH9ItC2Mxl0P1Rlt8GEvsqQz0qmm13kPA=;
 b=GrwfLKVovJN2hrsd65xR+lwXsCHCwzmG6fN1dcPDb64R+0ZAAWVzta6wldUC7CTqrezCZehBhzYOho3EneyR4edCKGEHAURzoELY/oTWT0wL3PTwp74y5fhrhVLoOWsxh5Nt+ScOEDLYAYacLOTe2n6Lh3ZLlgYR1TZLYM4/JH0=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by IA1PR21MB3547.namprd21.prod.outlook.com (2603:10b6:208:3e0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.4; Mon, 30 Jan
 2023 09:47:27 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::c14e:c8f3:c27a:af3d]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::c14e:c8f3:c27a:af3d%5]) with mapi id 15.20.6086.004; Mon, 30 Jan 2023
 09:47:26 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Olaf Hering <olaf@aepfle.de>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Souradeep Chakrabarti <schakrabarti@microsoft.com>,
        Wei Hu <weh@microsoft.com>,
        Shradha Gupta <shradhagupta@microsoft.com>,
        Saurabh Singh Sengar <ssengar@microsoft.com>
Subject: RE: unlocked access to struct irq_data->chip_data in pci_hyperv
Thread-Topic: unlocked access to struct irq_data->chip_data in pci_hyperv
Thread-Index: AQHZMN8ULW2JM/f89Ea+t0LgPC7SrK6viawg
Date:   Mon, 30 Jan 2023 09:47:26 +0000
Message-ID: <SA1PR21MB13357399D01FD4DBC3C3BC5FBFD39@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20230125180411.4742f159.olaf@aepfle.de>
In-Reply-To: <20230125180411.4742f159.olaf@aepfle.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e3ed9e06-d912-43ec-9638-d531340fcd39;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-01-25T19:46:24Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|IA1PR21MB3547:EE_
x-ms-office365-filtering-correlation-id: 60953d4a-6170-464b-ce99-08db02a6fe9b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Sh/xNRa+u430lMNC5urkZiGr+089ljqvAZyUAL/WOMYv5uTGB7zUZaUUqyUyUl97815Sjuz2dIQkVteaII6ZUw3YLKLCKtULiIbU5MX6mAGaflk33n0TzUk+lT5HEU2ersKwNlVmKNOm7iUgE37EUmxk0sArQxMwKOWEZNqj4VX4Zv5f0C4w1xbwURieqpTA/OIJmlUFjKMJukWngm1yJIzILz5mF5iV6zvNMNso+/UdGqTVlQApkdnauYwQlYxCL+uUYQAnpxZYS7jXJjZhxNOnbzpne0Dw/cqPc2foFUAOeKKyBY7qNUj8WrMNLGKAGyHEyIv+OjGcbmbzb53e345+J0yxvh8AZz6f9w+bVEE3TvRy0eZEJ0/7SzQLycKdt6P/HvLruiFQJPfK9ePQ24eJLTIZ244ftHC70bQ6IFv/TUHoGmtAPqxIsvPWlp6CSDKtGrAV5cafW4KxanIU1qqUyGpT00/xGK0eR/IsW+2bGvW0KppwPOizyeCNBRzu/ONB639hbVsNt97b4U7qMPohYB122x+bYq3hmOUb+37tYZShzVz1OFx32SErFsxz3cwPOHYqSlcSONl4ECRZ8MnInq0VcZfT5zFVYz5TlS0EbCn/o7R8TcweF92IDw7WN5h7G55hNwvNO/qSWkSFHco0IqxUka+JQ/JvPSx9wQyn/APirsw6vZpLw355J/RN9+JgsbPydtgeeFAkTfbci7crvxOwwldrlAQMC8dDsynfMxI2k5x8/+2K64ognVJQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(136003)(366004)(39860400002)(396003)(451199018)(71200400001)(8990500004)(86362001)(122000001)(316002)(33656002)(52536014)(8936002)(83380400001)(41300700001)(55016003)(64756008)(5660300002)(66556008)(66446008)(66476007)(8676002)(4326008)(76116006)(66946007)(10290500003)(2906002)(54906003)(6636002)(110136005)(478600001)(9686003)(107886003)(26005)(186003)(53546011)(6506007)(82950400001)(7696005)(82960400001)(38100700002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0w4qv9vQeiLWwer4drdAtXJBh94vcEwyPZ1FjisatkdtwtNjJ/NxOrNRvGlO?=
 =?us-ascii?Q?5r41aSi7lw+E+h3Wam7ecLrcPFcPo+psmlvWq4PzjwAzMQRC8ix/pk9pqX2o?=
 =?us-ascii?Q?jMRFWz/0quE5VR7LvFB+48OJO41E2YmsdyiQsDz81JGdheRywZst0wUoq8iq?=
 =?us-ascii?Q?XZmZGV9Ap2Va7esCy/dSpvwJTArpHnoM+0gGOdBmQrpndkJke9DRFZ2ad/ja?=
 =?us-ascii?Q?lmXOT3kxzNemyzic8dknHlmadiskjfrWq9hpQjCkikPGQxM6POOVgM9PusU9?=
 =?us-ascii?Q?3LQ+bEIxGAlowflyw18XZ6Xi5doMGMbxPXe3TLieUdcYmfXhnoALgq1RprBY?=
 =?us-ascii?Q?gke0VY9Z2maJUdOKdvibvPk0lg/IDYFOD+ce3ImteNaQqr75Bzwq9tfRQBuK?=
 =?us-ascii?Q?fOQrW7lonsiBsSIsbUkxjoXoq72OPKm8ODUDhgoBhkboyDWdDKeB07eiomyH?=
 =?us-ascii?Q?7wnG5ysbXTb9+2FsREExCg3bujB6Sk6XwUQtWI97+ul+N6C3zJ2lk7PeuuN5?=
 =?us-ascii?Q?kLcQH+XXT/0S6dCTMHPsGAXPuwkOm9SJPeAjgPxdLZZHBlOF6HqZQ0/g2fN4?=
 =?us-ascii?Q?O+nv1ekX+aAVbUSJ17/miOOoRl5mNx5DY5cUn89tPPii6ojxD0c2UV2qy+2S?=
 =?us-ascii?Q?T+77nyRoYUWZT0+NpHDWG0DY4iSfBjJe0Il4tQQkkAmPSrpz6dSYkJCuxacr?=
 =?us-ascii?Q?kR1ToHjov46gNdBcB+pgt8CIdGoluINpwQHrNhjXhDTd7vdg8rsWH6S2epvD?=
 =?us-ascii?Q?OVWBMov30s7dJdsHwlzZ99zJeFswn0BphnkCeq2Q0vok1gbtGyHe0Q42ThrK?=
 =?us-ascii?Q?N+Ep6L1SQx+zMbQ6XRNtLU4QffDN/7VaNd8+5BIlRvSf9zCW9ZZvV+TxsOR7?=
 =?us-ascii?Q?/1fcmW9m61aN4xUtKp399hiDMu6yTLlr5lNjGMzE3ES4EZdO1CqSH2voDgER?=
 =?us-ascii?Q?feoYZA01Bcxc9Nk+NRfBD0+qGh86vA8xjsxZIZUxIxXLJxt1Y4WP3pSGLEgz?=
 =?us-ascii?Q?PzUrfHIO6mKDMP+RVEM1/1XOYCBpP1NxWldfhBiOXQd7nfEzc5hUWQL+9Am+?=
 =?us-ascii?Q?aDXdd2K2SzIEizcf8GaBQobUG4KjNAH0cr9rosQ9j+fiW9HMaPvhSrKsvO16?=
 =?us-ascii?Q?KC2SdMpFp8A/ik6svqhcmao0qw1JSHO78rFz3fUQ42XNvIGygUh5ldAOi5ql?=
 =?us-ascii?Q?xn5r/zZxLSnnNwrH7DD/Y6jCgelocr5DWjuy3l1VrNgmXdt8LHp3AFG+u7/D?=
 =?us-ascii?Q?YTEhthu0DeR2nNmWrmdMRCNuBfqr/EP+VLBGNSZ43ML2CYFNZ0glE1MGqJAw?=
 =?us-ascii?Q?0xhuG5/PPV1VyO3IRTujkn2sSf7ffyZd02Y8+a2/U/HtyAIeFzQT2919wYNe?=
 =?us-ascii?Q?ORrTZtAelWSlACB18GJ/nvu11PukPLU8TbZxMUGmyQ6CUoxbtHxtoWL44UV2?=
 =?us-ascii?Q?Z77ZDAbS+lqpoGL+Vpzkq91bQcbzGRplsg9CMzM03wlEUaPOtnCWar1YyCXT?=
 =?us-ascii?Q?dPp2L6nkaaW6eRW0+RPZ+dhVgcan9K8J2r6C5ItxdK1vEwcuR305tvzUdwSc?=
 =?us-ascii?Q?9hLkKQtRuk1JonsRe/i6Crf6q/Ex3rLVnP1YnhYI?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60953d4a-6170-464b-ce99-08db02a6fe9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2023 09:47:26.2039
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H/+2VTZCIYjlNpUO8YSNhAFTtayMOa4HxbFt5Qgbeeb8k4ZwRsNlIKfaFpiphHOVqmQaqv4cvBv1TkMWmatr8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR21MB3547
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Olaf Hering <olaf@aepfle.de>
> Sent: Wednesday, January 25, 2023 9:04 AM
> To: linux-hyperv@vger.kernel.org; Haiyang Zhang <haiyangz@microsoft.com>
> Cc: linux-pci@vger.kernel.org; Dexuan Cui <decui@microsoft.com>
> Subject: unlocked access to struct irq_data->chip_data in pci_hyperv
>=20
> Hello,
>=20
> there are several crash reports due to struct irq_data->chip_data being N=
ULL.
>=20
> I was under the impression all the "recent changes" to pci-hyperv.c
> would fix them. But apparently this specific issue is still there.

Hi Olaf, thanks for debugging the issue! AFAIK, the last batch of patches f=
or
the vPCI driver were from Andrea Parri, who made the patches in April 2022.

We hoped that all the VM crash issues could be fixed by Andrea's patches,
but it looks like some recent reports of call-traces imply that there are s=
till
some race condition bugs to be investigated. We're working on this and
hopefully we'll get to the bottom of this.

> What does serialize read and write access to struct irq_data->chip_data?
> It seems hv_msi_free can run while other code paths still access at least
> ->chip_data.

I see this comment in hv_compose_msi_msg():
        /*
         * Record the assignment so that this can be unwound later. Using
         * irq_set_chip_data() here would be appropriate, but the lock it t=
akes
         * is already held.
         */
So it looks like to me that hv_compose_msi_msg() may not buggy, but I'll
double check the locking here.

I suspect some of the crashes happen because the host starts to remove the
VF device before the VF device is fully initialized by the pci-hyperv drive=
r and/or
the Mellanox VF driver, i.e. I suspect the race conditon(s) may be between
hv_eject_device_work()/hv_pci_remove() and the async-probing Mellanox
VF driver's probe() function.

> The change below may reduce the window, but I'm not confident this would
> actually resolve the concurrency issues.
>=20
>=20
> Olaf
>=20
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -1760,8 +1760,9 @@ static void hv_compose_msi_msg(struct irq_data
> *data, struct msi_msg *msg)
>  		    msi_desc->nvec_used > 1;
>=20
>  	/* Reuse the previous allocation */
> -	if (data->chip_data && multi_msi) {
> -		int_desc =3D data->chip_data;
> +	virt_rmb();
> +	int_desc =3D READ_ONCE(data->chip_data);
> +	if (int_desc && multi_msi) {
>  		msg->address_hi =3D int_desc->address >> 32;
>  		msg->address_lo =3D int_desc->address & 0xffffffff;
>  		msg->data =3D int_desc->data;
> @@ -1778,8 +1779,9 @@ static void hv_compose_msi_msg(struct irq_data
> *data, struct msi_msg *msg)
>  		goto return_null_message;
>=20
>  	/* Free any previous message that might have already been composed. */
> -	if (data->chip_data && !multi_msi) {
> -		int_desc =3D data->chip_data;
> +	virt_rmb();
> +	int_desc =3D READ_ONCE(data->chip_data);
> +	if (int_desc && !multi_msi) {
>  		data->chip_data =3D NULL;
>  		hv_int_desc_free(hpdev, int_desc);
>  	}


