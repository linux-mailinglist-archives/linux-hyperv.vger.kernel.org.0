Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6413F58E4
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Aug 2021 09:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232797AbhHXHYK (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 24 Aug 2021 03:24:10 -0400
Received: from mail-oln040093008013.outbound.protection.outlook.com ([40.93.8.13]:62848
        "EHLO outbound.mail.eo.outlook.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231945AbhHXHYK (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 24 Aug 2021 03:24:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lyjyVTp+Oqvs1g1/UQa4TQ7QoA8l572XJJt42z4uacbuHAj9r0u7GTX2DVDEKmxM+F+OtBE+OESiX4mIJ4AYtMOFIGGC1pOeKVlKE612JEo/vcJ/2YpO3bRvgG1Jzww8opbLZUHnmigw8Hlt0tPEsDd8p3B6CpFP2VbySOT6BfPxhXkwEqqzAJd+kWF996BK9t+ujOrHiXC2WaM/AJqwohXsS0DG9AZWFtqddYfuDyETCFSv/hL347XUzb506QaXxOLDF0AsANQfpMDOuH6KR5RqUN80DKThJQ53PtYscGyDJrxVgrjUh7MP7vRj0oc5mZ37x1NWN28whI1LyENE4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S153v2KDJSmNAmf+LpZ/SjpgLudG4tJyr3IylsGIJ8s=;
 b=DuogZ76pEkjbutQywmGSrNUKH9rtvDZrX396GpeOrCLd0BQcz0fpdpxkygkMPVShx2fqhgLUAIFq4DUG8blaIosxewpz8TeipufeJdXJdsXeFz+Zr8PXAUyTu9cLBzZY3vDVcAQ5g1clowM8aRrVw1KOK9T8WsbubErJ38KSVXzZknNv3wC7heFujrDhoRmU2WsZbA0MKRXy0Z7K+93R52ubFM0RSQqyVCb/o7MokBdswSOTwWnqBDQWFufxP7HI9wLhuae9qGFkgB1kpieyWR1dQSpDknee7egwiw6FCUpUooC5UOsnakrTbY4Y+OrHZFYAuAjLOo/q6SmFO74h/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S153v2KDJSmNAmf+LpZ/SjpgLudG4tJyr3IylsGIJ8s=;
 b=XGMA7XmPk+mjUrfk3nPl8dBrZvGUqpRJkJy2PZQUNMNduDfir40ALgTTGRfFXRmgEDbRl2iwd6jlxsuIklCzupD/yP5JCD+JhLoLe9tKGznP+orDmMzet+mCE24wduXjGeLSnzFTFjxYN9i7Fs5YMc4bhZYV8jHhUWiHyhCmqJI=
Received: from BY5PR21MB1506.namprd21.prod.outlook.com (2603:10b6:a03:23d::12)
 by BYAPR21MB1160.namprd21.prod.outlook.com (2603:10b6:a03:103::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.9; Tue, 24 Aug
 2021 07:23:24 +0000
Received: from BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::75cf:f11d:d80d:dfd4]) by BY5PR21MB1506.namprd21.prod.outlook.com
 ([fe80::75cf:f11d:d80d:dfd4%2]) with mapi id 15.20.4436.016; Tue, 24 Aug 2021
 07:23:24 +0000
From:   Long Li <longli@microsoft.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [bug report] PCI: hv: Fix a race condition when removing the
 device
Thread-Topic: [bug report] PCI: hv: Fix a race condition when removing the
 device
Thread-Index: AQHXmDKWcqullnxl5U6h5vjzi3pLpquCQS9A
Date:   Tue, 24 Aug 2021 07:23:24 +0000
Message-ID: <BY5PR21MB1506E144FA993DB38458599CCEC59@BY5PR21MB1506.namprd21.prod.outlook.com>
References: <20210823152130.GA21501@kili>
In-Reply-To: <20210823152130.GA21501@kili>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=64e81df0-6be3-4b3e-892d-25613eb5d7a9;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-08-24T07:22:26Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 49da3a4a-4ba3-4265-4b40-08d966d00f3d
x-ms-traffictypediagnostic: BYAPR21MB1160:
x-microsoft-antispam-prvs: <BYAPR21MB11605773C3AB05A144BE9128CEC59@BYAPR21MB1160.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gpIHjBkeblgL4U1yuT0FWJc+f7km6H5MdjGKW71pP96axcJBSbMxINNR1OFJa4dBTSMs8plW6nWe8dSqIbnzpGWzC22u+rGsxs0h68PZpuop+fxSol+BvABj2D5B+G2kB90I7lX4OUrT9DyBodVlq1YDciYllNG7bq8fxt7CxPaYQ8/vAVNNXQQPm+TeB1bDQjzL/y/VViNoIaTZkT3/ekusluGAyl9UncfVrZKNRKQSM321b182wqQ3mscCGelf1ceOVclf8mrmJn8g97rBeOptdSddIO1YbnlnabndjKXscGLdOsInZ5B+Trwgwh2hVdnL1v/Vw6wB++l9MSVfD37vZLJelwJohRy2Q9h55XrW0Tv4icItvSrL/g5WhIVUVW9344kyoLJQCEwaIcGvE4QsDnHyYeJ/lYXUAM/F4MosM2KOiAmFLix3JowtGJmxAX1PtyBQgrpADdtSig4IgW7ayoqfiIkqQKbuZ/grMwKbvMTRMMiPKzNLmR0+nSqnp2dY3qssGaNZIqshlP8iPbIakTv751YNvhhMQxY/b/Z8vUXRoNBYo++6oUsxnEk2l0eT7bB8kXhcmmqzWwe+XnZ9L18qaSXmlNVDRc+XDrgI7GEVFYAuGfVKlS8I9fthPf0EGzTnSP3O2aihDMmdTn8iZFE32TAIxIYiXbsBJmvA+1oohhu1uUsmp1olBpGW9ueRTv8TNUk2fp+0Jy9oSA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR21MB1506.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(82950400001)(82960400001)(26005)(316002)(83380400001)(8936002)(66476007)(8676002)(8990500004)(66446008)(64756008)(66556008)(66946007)(9686003)(186003)(6506007)(33656002)(508600001)(76116006)(55016002)(5660300002)(7696005)(4326008)(38070700005)(6916009)(10290500003)(122000001)(38100700002)(52536014)(2906002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Fojs5empOj8bNFT8bo/bUpSQGB35FHdWqenIONLEAyPzB2hAx6FHS4MFSWuZ?=
 =?us-ascii?Q?8JB62I7fL1RjJxh6ylIjmlpkfIylKontom+aJxsdRCI3EKTbAyyh9oCTs61I?=
 =?us-ascii?Q?+sosHibufsItKcEP6zLJWabnsViUnXu+OK9GRZPNx96B8D9Ht42GikZSNUTU?=
 =?us-ascii?Q?XN7ffdn6Gf27k+KcZkU0xevrsAwKhw0Z7d6XkVysI/EIDH7gSRcR5ofMg9sS?=
 =?us-ascii?Q?qhoo6C1fBPl7I2oSnKCid5Z0+hWob9e70MaJiKXSJ89TjwkuquYFYDSjSAMU?=
 =?us-ascii?Q?qlI9hK652oeiCQVdXjSHo8pG5oVeJHSmGKMr6a3IESG4n7fh2ijjj7PjZ3eB?=
 =?us-ascii?Q?arYQHgRVv3G80Bfusj1F822GcpQqKmADLXVwudZrv0Dg2Z//pk5qRxv1kpVX?=
 =?us-ascii?Q?NQotYq8ZAWb5XDI8nuWUWiYiOgr3bkphVTMYk18xelZECErEHPljEkAbrV0P?=
 =?us-ascii?Q?KEz/3JiQBc3tj/Gpdmerfb1RH6j7KrBKAlom9krqu8ObaW+TFcIA/DfbRiho?=
 =?us-ascii?Q?ROuwsyCoHyrqx4pc9wBDjqsTPhm2t62QFrrTjpzj31YqmmuFDZ6d+s01eleu?=
 =?us-ascii?Q?IJqqTckCeJCM0BguoMVRU9NMMVqNqWrT4da1s9R0b/xiAJNcw9WIed/F43iM?=
 =?us-ascii?Q?mB+hJYCfDZxi372t8+XTK/QOomiBzzGKpu0kbPxS0uIZSfAUilUvpBQoL8rc?=
 =?us-ascii?Q?T60YAIGSeCt1Opur8kswQ8U6vvWehdZv3hSQ2dcbN0m6L/Rsu37Jx/LjbqIi?=
 =?us-ascii?Q?RnRBP7m9hxxA4sQip7mZAxLfs7ifCwHSzve9N+3cgAlHR3ZE0e2+t1u3Cujw?=
 =?us-ascii?Q?snbArF6Fdo1YxQCuL8Hkvx5G1ruUJ/1Uo6FDC/ZJRLuoVTELJyEpfd4BSQK+?=
 =?us-ascii?Q?B+vHLN2gB/LERWgwovVGRmS+wkndAJ7ZsbzdVK5PW1bw+FpH7yJKsQ+B4Ofe?=
 =?us-ascii?Q?1psZ05Sn1IuNLkFH8wjxXnZwSoXaSgBhxz7ADauyix5O4t8T3YJkjgFq9Aov?=
 =?us-ascii?Q?W1yVx6wjoLUO0LXAimsQJradi6FDiqkKGSMZ4zyxukj4B4+V+XcM2VMWL76d?=
 =?us-ascii?Q?qS6B/CiUBi6LN3hp3/ZTLFvLg6ZQFaoM+mpONRZsgN4TskpIUck0kXMMr0RG?=
 =?us-ascii?Q?25Hz+J6RDQNMvPksbdGDS+SKktgKeHrOYY0FzSY67w7ZimHNusAv6OFa0c3f?=
 =?us-ascii?Q?u5I7lQPWB51FWe00C293I0Wg5UMYZoQWGnhDCfv/drA+JFX8fs8/lw+djSqf?=
 =?us-ascii?Q?s/Z1Ww6ahEhOChSVZjtJ+fxwsr0NiwpeT5JB3Fl07o/zu88oSkaNCwkfl/bn?=
 =?us-ascii?Q?JqI=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR21MB1506.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49da3a4a-4ba3-4265-4b40-08d966d00f3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2021 07:23:24.3157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YyNB9kGnaHPhhMT+vCm3WZDGVok8quIcpcO5zl3RlEM7U07lNJ1kP2oPU6Fmhg4qgocFiuOB0Ur05i07dZk0Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR21MB1160
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> Subject: [bug report] PCI: hv: Fix a race condition when removing the dev=
ice
>=20
> Hello Long Li,
>=20
> The patch 94d22763207a: "PCI: hv: Fix a race condition when removing the
> device" from May 12, 2021, leads to the following Smatch static checker
> warning:
>=20
> 	drivers/pci/controller/pci-hyperv.c:3294 hv_pci_bus_exit()
> 	warn: sleeping in atomic context
>=20
> drivers/pci/controller/pci-hyperv.c
>     3287
>     3288 	if (!keep_devs) {
>     3289 		/* Delete any children which might still exist. */
>     3290 		spin_lock_irqsave(&hbus->device_list_lock, flags);
>                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> This takes a spinlock.
>=20
>     3291 		list_for_each_entry_safe(hpdev, tmp, &hbus->children,
> list_entry) {
>     3292 			list_del(&hpdev->list_entry);
>     3293 			if (hpdev->pci_slot)
> --> 3294 				pci_destroy_slot(hpdev->pci_slot);
>                                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
 The
> pci_destroy_slot() function takes a mutex and you can't take a mutex when
> you're holding a spinlock because it can sleep.
>=20
>     3295 			/* For the two refs got in new_pcichild_device() */
>     3296 			put_pcichild(hpdev);
>     3297 			put_pcichild(hpdev);
>     3298 		}
>     3299 		spin_unlock_irqrestore(&hbus->device_list_lock, flags);
>     3300 	}
>     3301
>     3302 	ret =3D hv_send_resources_released(hdev);
>     3303 	if (ret) {
>     3304 		dev_err(&hdev->device,
>=20
> regards,
> dan carpenter

Thank you, Dan. I have submitted a patch to fix this.

Long
