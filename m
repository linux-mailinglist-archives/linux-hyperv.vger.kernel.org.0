Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B71B1A48DE
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Apr 2020 19:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgDJRS0 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 10 Apr 2020 13:18:26 -0400
Received: from mail-dm6nam12on2131.outbound.protection.outlook.com ([40.107.243.131]:23734
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726181AbgDJRSZ (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 10 Apr 2020 13:18:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NcqkZmyT7FyQuWNm/Ux/nExtuVjN5eGo3EbMoT/SNlQfDf+40uT2hH5d1iAgCDsITTBR8Zyduj57YSjJhew+uPaTTHlOO1vXdg4Ovsz1FiJor1A2lIOSI2C0DHA0LwTWPMHKG56iB/pLLIQwQbM4nW08qKJsh2D08YjduY2MZa4Jc9hSwmIlkMSw4nSj2dVrVZOHk8/wHKeQYc5Af/qFZ/UlnVMmeOxhv6W2N5iQTjAcalfoH52tUe9ipT+bpFlwtVIMd8Rn/3bKEsqrHrNg8aXhgW0szvZm2S4zToqZqRxH8G2G/9d14ndDKt2qcgQAReaM/EDtzWLKpaaiMe0IVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rhp/U2zqB+d7D6PyXZ31UdIX9pCudMIKVpVfzbn52Uw=;
 b=MsjfFZJXAD8MRyR6cowP83+H7Gl7bSdEzR0G8b/HGijnPHoiC/+x280rwKzq8PoeIpHJitLFhz4gnr6BxFD/SOiXqzbmG2ghA+8FXFsYO4q3SaPbPzRwPEtwJEP3Wad4UfFhBap6xyO4EqJNKENCkyRC+NM4Md8XMkxlfSXO9MN9jdM4vM29nvwM0h2O/utp48idVjovufA/qYIQxRP8yQ+ncEAw7s/92d/wfggG1k/E8RJyEjyMJPOAxesnEZCkZlfcmBYCOC5lxkoWcda+lUNRxSBO9A42mW8CrIQzvm+k2Y8JFF7m3xpaYvPvxsXqde41dA0b6OZGs00ol6WItg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rhp/U2zqB+d7D6PyXZ31UdIX9pCudMIKVpVfzbn52Uw=;
 b=OTm5EWA/6IzjVY4FtGA2appvXKC9cZpaXlprIQbzl+SPElHwrnbU+ou9eHfM2mxM7hUs4cpMPgTaGeNPwUTr2Y7yf6ic5ZnYGcAUB/C+7EbY1ifTjH67q2yqL1GfxqvniagbHqeOXc9BZzRT8WB2kkHt2Dzc0e+T/xHR8G4W3v4=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MW2PR2101MB1049.namprd21.prod.outlook.com (2603:10b6:302:a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.18; Fri, 10 Apr
 2020 17:18:22 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156%9]) with mapi id 15.20.2900.015; Fri, 10 Apr 2020
 17:18:22 +0000
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
Subject: RE: [PATCH 01/11] Drivers: hv: vmbus: Always handle the VMBus
 messages on CPU0
Thread-Topic: [PATCH 01/11] Drivers: hv: vmbus: Always handle the VMBus
 messages on CPU0
Thread-Index: AQHWC6imTi8OATtO/kWMIYPL49c6q6hyoGmg
Date:   Fri, 10 Apr 2020 17:18:22 +0000
Message-ID: <MW2PR2101MB10529D6F9A08CCAEB5B6D1E1D7DE0@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20200406001514.19876-1-parri.andrea@gmail.com>
 <20200406001514.19876-2-parri.andrea@gmail.com>
In-Reply-To: <20200406001514.19876-2-parri.andrea@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-04-10T17:18:20.2405592Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=099f8601-8672-4885-8d09-e3d6ae16c885;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e43eef4a-9e8a-4883-0a94-08d7dd732bf7
x-ms-traffictypediagnostic: MW2PR2101MB1049:|MW2PR2101MB1049:|MW2PR2101MB1049:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB1049A1395E2504AE55D60AB2D7DE0@MW2PR2101MB1049.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0369E8196C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(26005)(76116006)(5660300002)(66946007)(6506007)(64756008)(52536014)(55016002)(4326008)(81156014)(316002)(66476007)(66556008)(8936002)(9686003)(8676002)(66446008)(33656002)(82960400001)(86362001)(82950400001)(2906002)(186003)(54906003)(110136005)(478600001)(8990500004)(15650500001)(7696005)(10290500003)(71200400001);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2T7qIhDAWbn/7dhoxYUZao3+Q7oz9XIkjW2cwAKbjplH0sTs/pp9O8SrcD4zrYwgJHPb8MHdfTCamWQx0tekOOVSwpBZQ4TEOyet2jYXDMWhBCq8/v8HrBKaObVw9PbeIF5QZypjDaSqRiEZitr2uN+GCJvDVzf/Bj9bY/tp6DK836i3CXftt0aMAIpPj3khFOBjojzpLRPxp15L6Mk+WqSzjJUPXpoj6rlUlBbebZH97oxB9RtOLQPFDxPqZnLGR6WFsPHOMlS30W1HAxEKy7Nuyr9xjjHA9NTHd6sF/WUyPYd7WsGsnE43iPBmfOCWiZewvDLQl1U3eNhraOl8K1bDkk9IlxgD3+9LjNecQSG8RHRIysQw7Yz/19BBjO4E1BQQTZP3SJimR58t57cYE0Lgh+FJxozMunExf/Q2I5f3AcZ89NqVX8cxUnsI1X0C
x-ms-exchange-antispam-messagedata: dA5ujb1HST326jWAfQjmAkZlFWQSifsu2prbC7MLG036HZi39zyTXAEAGpd8DBqjYTlMdgqy+afzk+0zTunw2pMy3dFJcakPNinxhaIFnqPcoXIhrmdgdW4sCOsZmWCWnbr55hbDUQbMIGF0OKAYfQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e43eef4a-9e8a-4883-0a94-08d7dd732bf7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2020 17:18:22.3663
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vWnz0eQXyi4I9FHgfoedAg7ngZ3CtV/bJOASWTz4qWqsp0cbMpv9JxpTPgnuWsRlYoEpbLeZ/dYXWlHHGTEVzkTrIpe7aN8k5zbvVtqW4LE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1049
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Andrea Parri (Microsoft) <parri.andrea@gmail.com> Sent: Sunday, April=
 5, 2020 5:15 PM
>=20
> A Linux guest have to pick a "connect CPU" to communicate with the
> Hyper-V host.  This CPU can not be taken offline because Hyper-V does
> not provide a way to change that CPU assignment.
>=20
> Current code sets the connect CPU to whatever CPU ends up running the
> function vmbus_negotiate_version(), and this will generate problems if
> that CPU is taken offine.
>=20
> Establish CPU0 as the connect CPU, and add logics to prevents the
> connect CPU from being taken offline.   We could pick some other CPU,
> and we could pick that "other CPU" dynamically if there was a reason to
> do so at some point in the future.  But for now, #defining the connect
> CPU to 0 is the most straightforward and least complex solution.
>=20
> While on this, add inline comments explaining "why" offer and rescind
> messages should not be handled by a same serialized work queue.
>=20
> Suggested-by: Dexuan Cui <decui@microsoft.com>
> Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  drivers/hv/connection.c   | 20 +-------------------
>  drivers/hv/hv.c           |  7 +++++++
>  drivers/hv/hyperv_vmbus.h | 11 ++++++-----
>  drivers/hv/vmbus_drv.c    | 20 +++++++++++++++++---
>  4 files changed, 31 insertions(+), 27 deletions(-)

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
