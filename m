Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 694761A4A77
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Apr 2020 21:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgDJTdv (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 10 Apr 2020 15:33:51 -0400
Received: from mail-bn8nam12on2123.outbound.protection.outlook.com ([40.107.237.123]:5248
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726177AbgDJTdu (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 10 Apr 2020 15:33:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WwYR95C7brY6hxTXv1jtMdpWlB0LHj5r5/5yJf+FIwY8EiU331DAcr1NVMCThCbuug3qArxWHCgb+CUmtDy/VCNH4dI6pAf8ScEc/tV7juAAJhAEaB4UCozVjrT0pntgD1UQngrDi8wVDh49g90Vp4+MZNJV7zKadwB1ZV14gMZLV+Otq15FbwPRvBzywvEjGyMtV9FtWhQByvZ7mwKLS3mGKews/iyBkKuycpdBYXm8ZN9RsC82zq6iodWTwWVAlXOUlQSmaRzL8j48JV5O5Fp+wu9p1s8thO/qo+CV9Xq69GdfdJWkMfk3md8jXA8rA4w8LGS0jaI97zhiHjTw9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=11d43hU+Y+3LERG/ub05K/EJ3+OI8QgJjV2s26txDgU=;
 b=UmsiVhTROeNrTItOl2IKGzUDfiDzTT5GfpBRH7SBaRmOihgDFHTx5iAIJs7/XuZSKzul3gUmYUdM7dIVYgguvH7beK/7KMfdTk5C4LpwZpTgHOSlugVBcJqEKhkf4Qn23P29aUU2B4aZ7LE26HLTHcMv5vgXD1PmvYMkZdWKc0VTh8Q4Yb4nh/ykgNlLBorqKDX8xlBzY2yHp8BZIYzJADjDEpMR9G44fX8scLPC5srIjoYl7JjlG/PQ7S75T6yDOtcNuyXntrNx85HPxU9v2a3GX0l5l8tYwWEqOjhlU81XXw/75caeeVYYhiRxTQpcAzibBwXqUmnGYAHul+9PmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=11d43hU+Y+3LERG/ub05K/EJ3+OI8QgJjV2s26txDgU=;
 b=VIJ4IPini8nOLMoeJkGa6XBuRTmqWxIZwjkfpU6v1207YCpgrS7Rzc8gsMtQ0iA9et1SbOW3shdcwWccHH3VjMewRkOy+87FdIPW9f5xXeqwr/WWS8UMMoMs6CzwnZVG6E/B2kV3/eLtCgtCdSVQr5SMBYcVEE9rwpkdAtObUP0=
Received: from DM5PR2101MB1047.namprd21.prod.outlook.com (2603:10b6:4:9e::16)
 by DM5PR2101MB0999.namprd21.prod.outlook.com (2603:10b6:4:a8::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.7; Fri, 10 Apr
 2020 19:33:48 +0000
Received: from DM5PR2101MB1047.namprd21.prod.outlook.com
 ([fe80::f54c:68f0:35cd:d3a2]) by DM5PR2101MB1047.namprd21.prod.outlook.com
 ([fe80::f54c:68f0:35cd:d3a2%9]) with mapi id 15.20.2921.009; Fri, 10 Apr 2020
 19:33:48 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        vkuznets <vkuznets@redhat.com>
Subject: RE: [PATCH 09/11] Drivers: hv: vmbus: Synchronize init_vp_index() vs.
 CPU hotplug
Thread-Topic: [PATCH 09/11] Drivers: hv: vmbus: Synchronize init_vp_index()
 vs. CPU hotplug
Thread-Index: AQHWC6izYGPdkF4IY0O6b+yNKo8O5qhyxkVA
Date:   Fri, 10 Apr 2020 19:33:47 +0000
Message-ID: <DM5PR2101MB10473EA12E5ACBDB1E06A329D7DE0@DM5PR2101MB1047.namprd21.prod.outlook.com>
References: <20200406001514.19876-1-parri.andrea@gmail.com>
 <20200406001514.19876-10-parri.andrea@gmail.com>
In-Reply-To: <20200406001514.19876-10-parri.andrea@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-04-10T19:33:45.8080973Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=662b090a-2723-49fe-89e3-b096e45dca9e;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0798f4d2-363c-47eb-38b8-08d7dd861735
x-ms-traffictypediagnostic: DM5PR2101MB0999:|DM5PR2101MB0999:|DM5PR2101MB0999:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <DM5PR2101MB099949866C6504837E363B9DD7DE0@DM5PR2101MB0999.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-forefront-prvs: 0369E8196C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR2101MB1047.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(346002)(396003)(39860400002)(136003)(376002)(366004)(7696005)(55016002)(82950400001)(82960400001)(71200400001)(86362001)(186003)(4326008)(8676002)(4744005)(81156014)(8990500004)(478600001)(8936002)(26005)(66946007)(76116006)(66556008)(6506007)(9686003)(5660300002)(66476007)(64756008)(2906002)(66446008)(316002)(52536014)(10290500003)(54906003)(110136005)(33656002);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lWF4L75PmDYJDO3ZOGx8dOTEdbZJHBDIUP4Ibmx0U9XTQMWG/6mA3aLCeq05ujOc2a1CKSTc0jm+iRio6AxSee4FfP4sK4Xk77wLwiFao/UODFrKWzNyDTa98+gw7rNKeQcja7rxtH26RuRI7CIb1COWtyfiMSX0w9fygcey4gbyUWZWqH/QjAV+Bn+xailI+Zg2SH3r++ACZBF5myNspOEhkR8/labcSp3L6okaMj1dh/Z8oAP4bEB5Khyp3EoCrlOsSndKEAyzJB7TsSgUV+AtBLzHvC+YDAhg1N5pRkOlhkYGq/IhHgY7DPrfbUBEHGh9ixqK8byYrA2C1MR5NDw5+a/mDQU6jcoldXIgg8k5VaaKHVm4aM012XGD9NXdVpp3m3exprmdAlxEEW302Hnr2cy91pMzvFuQtIWTg6rQhjxEadFOEmZ/pt1TBWM0
x-ms-exchange-antispam-messagedata: n7IJyvGLzDzsNdMp3fLWxW3oyZE9VS/o175IOnLbdQPLREhxbcThmTmAZMfx5mmgMTeM8TvfAD/CoVv684p8zbgoiwvWCFRvZYDLlpa7Ofh3/txCykxX/eOE3em8KxPiu8mukRN91SLOf0s9K1e2pA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0798f4d2-363c-47eb-38b8-08d7dd861735
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2020 19:33:47.9355
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OTGdtI0LWh0BELNfJoAhaoUQswtlgMWWSz708yff9awmx7Y8L9nmfsVwKhCFSeb28dwy4G2DjT5rY17/DAh8icJXOluLxHGU5cnbHhw4dfM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0999
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Andrea Parri (Microsoft) <parri.andrea@gmail.com> Sent: Sunday, April=
 5, 2020 5:15 PM
>=20
> init_vp_index() may access the cpu_online_mask mask via its calls of
> cpumask_of_node().  Make sure to protect these accesses with a
> cpus_read_lock() critical section.
>=20
> Also, remove some (hardcoded) instances of CPU(0) from init_vp_index()
> and replace them with VMBUS_CONNECT_CPU.  The connect CPU can not go
> offline, since Hyper-V does not provide a way to change it.
>=20
> Finally, order the accesses of target_cpu from init_vp_index() and
> hv_synic_cleanup() by relying on the channel_mutex; this is achieved
> by moving the call of init_vp_index() into vmbus_process_offer().
>=20
> Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> ---
>  drivers/hv/channel_mgmt.c | 47 ++++++++++++++++++++++++++++-----------
>  drivers/hv/hv.c           |  7 +++---
>  2 files changed, 38 insertions(+), 16 deletions(-)
>=20

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
