Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE0E76D9E0
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Aug 2023 23:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbjHBVpm (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 2 Aug 2023 17:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233769AbjHBVp0 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 2 Aug 2023 17:45:26 -0400
Received: from DM6FTOPR00CU001.outbound.protection.outlook.com (mail-centralusazon11020016.outbound.protection.outlook.com [52.101.61.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6812F3C16;
        Wed,  2 Aug 2023 14:44:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KJVSWwHKCJcEUvdg86wGiKmgFlGdE8Rvf+P7Nd0yEkxbRHOANy7ZDSAOuxQs1poK5UA04K+rqyK/PdqpQIA0xsD4NI49+97vEtiTrI9MmsNKXVCn5TjbTYfmVdjfj/qO4tJrWM/VBwmlsXsdNvPzypNnIx8TaKwAqsUipHUHgS3/vRLEajn4BJobab87LkSr5V4sq7rurSEwnJwUdQ8tdeg99jy0Eneb1hZoEcYUTjjqP5NBGcJt+EaE9E1wY3rrSHxtb61/xY4CVGy1EFtIokTIf4GUFL8J+CfpbFjn0DsmqkVaS2qkvmfCZEsvwoB7YlR1hlCgbhPO/Bf56WtpcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JeJ+Ez/jl6y8HEnhyizpSBB2rCUh9xbD13pKn4z5CEA=;
 b=a8oV956lH4jFJ0S2vPQ8bSganVEhFBNgHeaivbIdVAKSNN24aLV4gh5nrADfLo9VS/OWcjWFgWNJZaAGW+YYomfXs2+1xzkyj5dwrtXU53azaqnhJLv6qoxj5S+vPoKmFkB8C3GswlVA0ZkVAzsyboz6XmhDYGt05N5iVqZLhSUVepx1e8PsPtGP/ati2v+sYUnglShYYIZNp5tvTIDL1nw1IumYwT3nGk8AKSFCS99isWpxy5tf4xvPdc2TNs+ZJc/ktUOrTlAPlrBi0ZTjfmCcWXli1fUdvqWVKZsHe6UtZXanMOf+XM9/X1pQh0z9GYJ8qWPNhXQts77BhwYFqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JeJ+Ez/jl6y8HEnhyizpSBB2rCUh9xbD13pKn4z5CEA=;
 b=LumcI1WRddp8RRPH2gzkQfGSuxU2xmnV/OJMIIGVSVbUnx9ZB0+TB4qQA1x9+wBoZuDs84MyaQon5QmWzFzhobdj7gBFIJ5ZNRLFAtrCP5zOUMtD8/0iXDWxarHBuLxJtnp/Npk9bekMjDSY3Ss8yKcrE49+ipcGTAuIXsowV0k=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by MN2PR21MB1536.namprd21.prod.outlook.com (2603:10b6:208:204::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.8; Wed, 2 Aug
 2023 21:43:52 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::b588:458f:b0dd:8b9f]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::b588:458f:b0dd:8b9f%3]) with mapi id 15.20.6652.004; Wed, 2 Aug 2023
 21:43:52 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Saurabh Sengar <ssengar@linux.microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [PATCH v3 1/3] uio: Add hv_vmbus_client driver
Thread-Topic: [PATCH v3 1/3] uio: Add hv_vmbus_client driver
Thread-Index: AQHZtj2ToD1GtuW2ikOTsIQSHjW1K6/Xp/WQ
Date:   Wed, 2 Aug 2023 21:43:52 +0000
Message-ID: <BYAPR21MB1688F466CE57FDBA27B9D6A3D70BA@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1689330346-5374-1-git-send-email-ssengar@linux.microsoft.com>
 <1689330346-5374-2-git-send-email-ssengar@linux.microsoft.com>
In-Reply-To: <1689330346-5374-2-git-send-email-ssengar@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=afd63bd1-fd25-4495-9b55-677c442bd9c4;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-02T21:42:22Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|MN2PR21MB1536:EE_
x-ms-office365-filtering-correlation-id: c252506d-1a2e-4954-4760-08db93a19052
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EqIn0VTIHtfl0PBvxyCbL8dJTWUD272bPavP3affQ5+xmoflbVboi7Qe5mQn9jgnbI0W/+F1vzztvY5rN4z4dAa5qkuE4KNEvzkg+L8onraA34aBSA8m6ZRwSvZnEKsqCfrEe6awUIZZrwfQ0McKR0qtLaBUL/g9SvjruKeDIf9tNWYsxiz5HdyAqWrsfB9rFLFEADOJjrF7hJKKN23//kQitRU7PUtdYPT2BXy5qhu9yRDwp9zovoJYvyeX+++XCc4SSUunax53p360M345Vn0IgQgFH2PevdloOqs/oC4VPkysTfKV5vzbPGNVfHLo39QbSg//aTmHU/sA1eGiuNfJ1YXt8Q0GoDrL2etbHgNY3awp6kGTaXjEEp/lWsPNjqyD5DwhnWa7+3UbHZrqpZMe5XBBUp454SLTBECgAh5q0gaAt9jM0WsQsZignhaKlKgz04e7lRwykqxiYoGutej3ZNH3jh8ijvv0UX4HDRMrAGAt2nnafsVp/TsekisUEpX1mRDjllZ6arAeD2EV+nr+ccuHIBpNPhhrt5dbxO0i9xfH+8m+Vq8maQHtMnLpzxitMUgWfNCOl6WOIwl7owUaVHJU8x30jIl4ayQWxP4JJwIfeg97VkBh/z1O/Jr4NeCgw3429sQjSopRS3uOzqn1ltdussUf3aFtNtGJBbV51YM9bVo/zkAZkizysFVg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(39860400002)(396003)(376002)(366004)(451199021)(33656002)(10290500003)(8990500004)(110136005)(9686003)(921005)(2906002)(38070700005)(478600001)(7696005)(83380400001)(82960400001)(86362001)(122000001)(82950400001)(71200400001)(76116006)(52536014)(786003)(316002)(64756008)(66556008)(66946007)(66446008)(66476007)(8936002)(8676002)(186003)(38100700002)(26005)(55016003)(5660300002)(41300700001)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0GlNKrciZ8rPMU3QTJ5popf3fTqBtgqEd/r5GCL4A5J4SNZSuNRkGFLWJCn7?=
 =?us-ascii?Q?+ZX2dxBrS7OhHJOeK1o+W4ebkKyPxLt5S65pDaisnry1c2hQOeLi3c6NPhQR?=
 =?us-ascii?Q?jiRYIFsuYhlcffdxZvNXPkoFlrNSMhc4OB2RHgytls0VReVPlPVckrbvRnNW?=
 =?us-ascii?Q?bRIF82CBY21T1bDFCvE3anhimrknsFQ7DAkRUMthi8+NHfka12HQx5cvorK3?=
 =?us-ascii?Q?Q9TF4TA0FxU04OSfmRtK760AnMgvUGOkPcmcFfGvuwq8O5KIAn+2ybeLbtPf?=
 =?us-ascii?Q?7ZLUboSKNG95edYf0di/GHjbO8xHd6L4wncediFgxFNIZfv0sLXlMtFkYZNw?=
 =?us-ascii?Q?Mlzn3GYDbbI8/05jxhLtGgtrOUhwb2w6pVHEjyM3xqyFGKPSFshKacQSm+Wi?=
 =?us-ascii?Q?gZ2wdWH7VrD21l2d851W/5m4vaA3GMN1EBpa82QRNCZKAiLdN7Xe1m+KEKkc?=
 =?us-ascii?Q?EC49uAZkccm7wFDlMD+JHc+vtgK9+1UXWeELfyzu/zvBcIPowd/Y1c5gCG1l?=
 =?us-ascii?Q?J303PV6oz4LS8WzIoyHhWsK0/TCBj9fIiV9fdFqJEw2BDBByE6qQBrCuPeLv?=
 =?us-ascii?Q?ArmxWJhC1IOhC3KtWXcfrc3/fShR1T8nH9joNZe3FRPXIuxOHmifGKVG5Fv5?=
 =?us-ascii?Q?QrEryun1Z0b6Mt253gnWZLDtqsPNVxnY3oZNQ7SllFkCCUOlekIlggyVJv8y?=
 =?us-ascii?Q?wA/PN2bSO/o7PmHv8mBFQBvqHADf8gvWzPG1jMpRgvjCsiGfW1Lp2TWgOZHx?=
 =?us-ascii?Q?bTdEQXhxIN/hKmdmjQPVk64cTn/nXkR/wiwAaUDLXryK67q4wqhDNvyz0Wxn?=
 =?us-ascii?Q?NVBolBQPNFDkcMgh6Lfs2xPVbNritxk2RgnZ2WOKNik94to9GcfZPfA+vPyX?=
 =?us-ascii?Q?59JPZ6O2svHWhUuuwBlt92S9+SdOq9sTuTX/HS+xvJ/c2Oj6D1ic0fAlYzOQ?=
 =?us-ascii?Q?2/eYLRPGMYvcdvu3vqxA6ClPmPSVP5NzHnY3LCQCEz71mEafhkKJBkHWek9z?=
 =?us-ascii?Q?vYg+pZlKe8ovf+UJCRIuZDFqLmNw/SNgmSN6nUzgKWNqCyigYIVWCxKxHC/L?=
 =?us-ascii?Q?6KzgqJtV49yaWfFLaJKV4Iu+Yth3EYaHJ27XfSoxUR5j1Az/1+dUBekXYibk?=
 =?us-ascii?Q?pSAU+zHhYIWDXMdpTWuj8E7RYvPg8YBuJumsxr4iXlT7bkykvDBGWPNo08/2?=
 =?us-ascii?Q?IHZ1yZiRXYrLH2vGJy+afp3gD1LYlmQkwvJ/8eGSFBslaXRMzOD1ZTt9YchC?=
 =?us-ascii?Q?SzSPIeYx+hB3Rr8OVW1GbMAXVE3ztI1x5FsZJ+lS59adKc4lxsjnusVFVosi?=
 =?us-ascii?Q?oYPiaE8+IaNkaaONImnaxW9YmAz+FkUILOf5YIBhUavnEeXIQEEfJ/mKPgnP?=
 =?us-ascii?Q?RV6xFTAJws5PklSdD8WqsL3ISs8dvI0gE58iw63dI6V6/+i7pbsCY0wG484i?=
 =?us-ascii?Q?L/C6jnQvU+ZSutVire5c7O4fGN3Z2EOlIQiDePD1Yk+Qpr2RrVoYs9YhUqAe?=
 =?us-ascii?Q?M0k+pilp1+q98i6eAGcfYs47Ef67qYc6HSQcEYYLLEm8zsKO7F2D4ViAKeTK?=
 =?us-ascii?Q?4lomM3bx6caS7fd6ABD8tg9XMidW0EBuMmsvrkgN/zzGobnlo6p7vD20Vid5?=
 =?us-ascii?Q?pg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c252506d-1a2e-4954-4760-08db93a19052
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2023 21:43:52.2802
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r02uygAu/p4oc1Ji9gadhgB1+0GWKxhyGrRct1e1eS57nbsQj9pGHaziX9rW4wQ7yb30YSmFNPJLg8g3zyYhShLWk/kfZ9D2/MSR0a+Or6M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR21MB1536
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Saurabh Sengar <ssengar@linux.microsoft.com> Sent: Friday, July 14, 2=
023 3:26 AM
>=20
> Add a new UIO-based driver that generically supports low speed Hyper-V
> VMBus devices. This driver can be bound to VMBus devices by user space
> drivers that provide device-specific management.
>=20
> The new driver provides the following core functionality, which is
> suitable for low speed devices:
> * A single VMBus channel for each device
> * Ability to specify the VMBus channel ring buffer size for each device
> * Host notification via a hypercall instead of monitor bits
>=20
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
> [V3]
> - Removed ringbuffer sysfs entry and used uio framework for mmap
> - Remove ".id_table =3D NULL"
> - kasprintf -> devm_kasprintf
> - Change global variable ring_size to per device
> - More checks on value which can be set for ring_size
> - Remove driverctl, and used echo command instead for driver documentatio=
n
> - Remove unnecessary one time use macros
> - Change kernel version and date for sysfs documentation
> - Update documentation
> - Better commit message
>=20
> [V2]
> - Update driver info in Documentation/driver-api/uio-howto.rst
> - Update ring_size sysfs info in Documentation/ABI/stable/sysfs-bus-vmbus
> - Remove DRIVER_VERSION
> - Remove refcnt
> - scnprintf -> sysfs_emit
> - sysfs_create_file -> ATTRIBUTE_GROUPS + ".driver.groups";
> - sysfs_create_bin_file -> device_create_bin_file
> - dev_notice -> dev_err
> - remove MODULE_VERSION
>=20
>  Documentation/ABI/stable/sysfs-bus-vmbus |  10 ++
>  Documentation/driver-api/uio-howto.rst   |  54 ++++++
>  drivers/uio/Kconfig                      |  12 ++
>  drivers/uio/Makefile                     |   1 +
>  drivers/uio/uio_hv_vmbus_client.c        | 218 +++++++++++++++++++++++
>  5 files changed, 295 insertions(+)
>  create mode 100644 drivers/uio/uio_hv_vmbus_client.c
>=20

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
