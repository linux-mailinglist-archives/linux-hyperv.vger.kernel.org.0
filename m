Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC2CBA8D51
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Sep 2019 21:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732044AbfIDQpV (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 4 Sep 2019 12:45:21 -0400
Received: from mail-eopbgr750117.outbound.protection.outlook.com ([40.107.75.117]:26990
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731829AbfIDQpV (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 4 Sep 2019 12:45:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aMmfM1+NB0kK5VY1yWqw+ITeehUzB4Ej79kqB7w4hyD7qsPuDFdwKPvQxd//hilgorLZesrUj/BstwjYbf3dzNcwspkRWHIk9JrSKBThjaA5eIswEs6GvM3eeV/A3Q6aCH1Rl98ivgZ5bXdOSntTSI//QBsrhGvUWq8x4F4MzgoCWzeEZdnWgYBs7x/hcVUuVK3xWUh35c6xgIckuOEWfea/KZyrt4CBrdgLWbQAJwLMZx1yL8i9227wvnPuB/fZwHcMxo56SMTIr3DwMhYePZX5d3OCQvJg/zsMfPqa3as89PHIoallp2GvJIpICEzf9b37N3LhcwuG7FHATZfC/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+UMmbkQQgps0qDH7JGZKHL6bGexVJrEcJ3RjHFW6DQU=;
 b=KCuFeGY+aQ/jFNoPAXtf+7JlYw8jylfPugnAUIHSoFc07NuW7KVGM431y+98vH1mszMt238id/9aLmnqAvE9qbTA5ykK03a8Hnenndi3U26g7wcRV+6iePmSpzK5IaTIXllk8BdMYF0mWJWAOBXn+rbCwzUCxfCTouhw78gfEtm9CZvkWgeZ+g53Od/BpLlCvS6x4RAJyxe0kgjZnJ9CCY4ouSJk53zdCnl+ajiU8U/UzFb1INyDahmg0ACZEgvh2CKI76NxoyFybkRU4SOIKQ2gXcv4xm6vcsEy+7G/zDvqP//6Jm2VRDwr+kp/nsvoSVObuvs68/IS7ity3DCuQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+UMmbkQQgps0qDH7JGZKHL6bGexVJrEcJ3RjHFW6DQU=;
 b=NZ0pNVtcccwhO0IT1rOwbbbxMGh/ryqaaEb0VwBlQlpVR8jpQm2B4Jm+mD1MqlXsLZuLxDxRmQgsqj0lmHGVdgTitrPYp5p9j7Vi5RB/zQnrvfJt829hlLvF8jiG7+wovZranOF+KF/bKKzWA7WXFrkFLJY6oMX/D43cJjneV3s=
Received: from DM5PR21MB0137.namprd21.prod.outlook.com (10.173.173.12) by
 DM5PR21MB0794.namprd21.prod.outlook.com (10.175.112.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.6; Wed, 4 Sep 2019 16:45:18 +0000
Received: from DM5PR21MB0137.namprd21.prod.outlook.com
 ([fe80::c437:6219:efcc:fb8a]) by DM5PR21MB0137.namprd21.prod.outlook.com
 ([fe80::c437:6219:efcc:fb8a%7]) with mapi id 15.20.2263.004; Wed, 4 Sep 2019
 16:45:18 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     Dexuan Cui <decui@microsoft.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 12/12] Drivers: hv: vmbus: Resume after fixing up old
 primary channels
Thread-Topic: [PATCH v4 12/12] Drivers: hv: vmbus: Resume after fixing up old
 primary channels
Thread-Index: AQHVYe3OX2xdqssLhU64Vvbm5PnvIacbvDcg
Date:   Wed, 4 Sep 2019 16:45:17 +0000
Message-ID: <DM5PR21MB0137435EDD570C34C72F0FC3D7B80@DM5PR21MB0137.namprd21.prod.outlook.com>
References: <1567470139-119355-1-git-send-email-decui@microsoft.com>
 <1567470139-119355-13-git-send-email-decui@microsoft.com>
In-Reply-To: <1567470139-119355-13-git-send-email-decui@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2019-09-04T16:45:16.1632429Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=0e7013d9-ba09-401a-b404-0cfd7cb59a19;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [2001:4898:80e8:a:c9a6:edf8:bca3:c905]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 95f3ac7f-4916-40ae-14dc-08d73157450a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DM5PR21MB0794;
x-ms-traffictypediagnostic: DM5PR21MB0794:|DM5PR21MB0794:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR21MB07940B3C9953F9156D58AD1BD7B80@DM5PR21MB0794.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:651;
x-forefront-prvs: 0150F3F97D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(136003)(39860400002)(346002)(396003)(376002)(199004)(189003)(10090500001)(6506007)(2906002)(33656002)(1511001)(66446008)(64756008)(66556008)(66476007)(66946007)(186003)(7696005)(76116006)(76176011)(102836004)(110136005)(22452003)(316002)(86362001)(81156014)(6116002)(4744005)(478600001)(81166006)(5660300002)(2501003)(2201001)(8936002)(10290500003)(8676002)(14454004)(14444005)(256004)(71190400001)(71200400001)(52536014)(486006)(25786009)(476003)(6246003)(53936002)(4326008)(46003)(11346002)(229853002)(446003)(8990500004)(74316002)(55016002)(7736002)(9686003)(305945005)(99286004)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR21MB0794;H:DM5PR21MB0137.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3Qz8nEoWZ3in5cfOaOw+kr7sg4/ykZjfOBkw2u85wdC/bLRURoPEWn4Zwbzc6Fq73gkD9csjMrgP7V6dlcqjaNBP7DNNPr8124PBcvf+eddCCP0txzQTGDrHn3q8DPk4Pu0dG3CDW0GSFpF8ct95ISswk55BUXvgwqJmH0teCXTSxbftllLZxScZqRsn68J+mRgyhsTUSu725ja9IDBm/goOFA2+UqZW9gGh002C1bZmeddOjmWjIGmbzV3ZWVxKujYHgHWHcDFz6ys17qadnUkOvr8ZT6vHEpKRRH5ra2dtlpZU4WoyyW7t9U06RBDexmfbpRK3K9cqpa3xfQlvT0nfardRUmX9GZfOTaH7qPGnP06awHncoLmm8WCCUDhHuak6gigodB49aTUj8USg+MsNW2ZwaOqE6KVDuKFytHo=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95f3ac7f-4916-40ae-14dc-08d73157450a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2019 16:45:17.6883
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1aSYdP16tXe19PmHdI/FYTH1mbhnc3y18dnsr2yIvz5Ka5Svn8fFU4WYcFm74lLXsfCV581VY4oUDVA9bhq3JaniM3YTSD5NC5LfIw7Rw5I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR21MB0794
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Dexuan Cui <decui@microsoft.com> Sent: Monday, September 2, 2019 5:23=
 PM
>=20
> When the host re-offers the primary channels upon resume, the host only
> guarantees the Instance GUID  doesn't change, so vmbus_bus_suspend()
> should invalidate channel->offermsg.child_relid and figure out the
> number of primary channels that need to be fixed up upon resume.
>=20
> Upon resume, vmbus_onoffer() finds the old channel structs, and maps
> the new offers to the old channels, and fixes up the old structs,
> and finally the resume callbacks of the VSC drivers will re-open
> the channels.
>=20
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
>  drivers/hv/channel_mgmt.c | 85 ++++++++++++++++++++++++++++++++++++-----=
------
>  drivers/hv/connection.c   |  2 ++
>  drivers/hv/hyperv_vmbus.h | 14 ++++++++
>  drivers/hv/vmbus_drv.c    | 17 ++++++++++
>  include/linux/hyperv.h    |  3 ++
>  5 files changed, 101 insertions(+), 20 deletions(-)
>=20

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
