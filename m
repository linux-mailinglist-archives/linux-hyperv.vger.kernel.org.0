Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 408C71A4A80
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Apr 2020 21:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgDJTe5 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 10 Apr 2020 15:34:57 -0400
Received: from mail-eopbgr770127.outbound.protection.outlook.com ([40.107.77.127]:2950
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726203AbgDJTe4 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 10 Apr 2020 15:34:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gsV4htpjnEbyUHTlNoqHbgRKHw0Z6nEMjz//ETuc0aSuqN/D+cXX8XAZ5+sPyPLkSSeJ+tYvynUMWDFzDaz/wvR35lfrzJ389168qJQ8jWQeosoAB+rfv6S1xAfK1U8jtL/KxqegNokeY+4EhzRH5YbYkVJTO5z0hspLfnecTHfI8AEb3pW0Yi2c+weqLM6NvALSzqcuHofCeqH6b2azknl97c1tQVoQkfURC3EOy9lico0NWzTjnvwA8ITJ9Et1Q7qhQJRZr5FnLroxZwhbBnWyTS965S9tEKB54QUajX4+vhh//rKYx4FvRASPp5IWYzsujWOPd89LB3KygmBb2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+aycy3WKNEXbtJFZcQXji2QHB2FpmhXDFErgj6Ktwh4=;
 b=bk3BH6wTgxt8TSnWJ13HbOTppk35qTepOR5fn1zLQ/6LIBRzZ8l2Gl/ZFveq5n01QBjTGnhGH0Q8PEmXaMmSYc/9+u2rQu/5xTEzuoeP48CDLnOX6IQV4D5RS6+9LfC+Miqv48/RnLzh/Ny1K/U2ugs5h2I1YdGEoIPcoMmE9TW82Mx1HnlraJ8/twSaolMZ5c1TS0aiqDZSHh40atotw67WuzQgUpmbpwuUT3TEzebLYcFT2AjdOGILtKvOSR904RGoFLZklf/TQdsSeg90PkCX3s4r+/RWv77GiKcm4Qp3tn35CIDlrQ5jBr1jXs90GbLOgBIW8EJ+Rp3K4w8E8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+aycy3WKNEXbtJFZcQXji2QHB2FpmhXDFErgj6Ktwh4=;
 b=IIuIal3jvLgEP5DUhnIl/YgRCWOCrSD366dDitowmj6DnVO7QQzCQ03CMKM5Ywa9bmIXyVjA7Bq4pjjtdfNBgWR3ZIDdhNn6qfVVqOnnbbBJ5Kp2a49TSNuEzh5sid38NL5BKYKvrtUkxgUCV/81DIml7x6JX1JuyIEC9pK9sc4=
Received: from DM5PR2101MB1047.namprd21.prod.outlook.com (2603:10b6:4:9e::16)
 by DM5PR2101MB1109.namprd21.prod.outlook.com (2603:10b6:4:a2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.12; Fri, 10 Apr
 2020 19:34:54 +0000
Received: from DM5PR2101MB1047.namprd21.prod.outlook.com
 ([fe80::f54c:68f0:35cd:d3a2]) by DM5PR2101MB1047.namprd21.prod.outlook.com
 ([fe80::f54c:68f0:35cd:d3a2%9]) with mapi id 15.20.2921.009; Fri, 10 Apr 2020
 19:34:54 +0000
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
Subject: RE: [PATCH 10/11] Drivers: hv: vmbus: Introduce the
 CHANNELMSG_MODIFYCHANNEL message type
Thread-Topic: [PATCH 10/11] Drivers: hv: vmbus: Introduce the
 CHANNELMSG_MODIFYCHANNEL message type
Thread-Index: AQHWC6i1xvWI2vXWuEqnRKadATfrK6hyxp9Q
Date:   Fri, 10 Apr 2020 19:34:53 +0000
Message-ID: <DM5PR2101MB104725BD244BB1F3B482821DD7DE0@DM5PR2101MB1047.namprd21.prod.outlook.com>
References: <20200406001514.19876-1-parri.andrea@gmail.com>
 <20200406001514.19876-11-parri.andrea@gmail.com>
In-Reply-To: <20200406001514.19876-11-parri.andrea@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-04-10T19:34:51.5117828Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8cd90f63-4fc0-478d-9382-7758b05f415b;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7ef65736-08e4-40a1-b23a-08d7dd863e9a
x-ms-traffictypediagnostic: DM5PR2101MB1109:|DM5PR2101MB1109:|DM5PR2101MB1109:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <DM5PR2101MB1109F8DC6E651D9C212F12A5D7DE0@DM5PR2101MB1109.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0369E8196C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR2101MB1047.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(136003)(39860400002)(346002)(376002)(366004)(396003)(10290500003)(478600001)(110136005)(71200400001)(2906002)(8990500004)(76116006)(8676002)(15650500001)(316002)(7696005)(186003)(54906003)(26005)(81156014)(5660300002)(66946007)(86362001)(66556008)(8936002)(52536014)(6506007)(66476007)(66446008)(9686003)(33656002)(4326008)(82960400001)(64756008)(55016002)(82950400001);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 047aQA8st6a2ft0GctMxpGuh/pS+kv0rCuIw7OzSEpu9sRVEMSO2uZax94HqGBDQHUeFKI+nIko05EgxxjPBb0ZQipyrIFZLmV/34SVAhLjCiNH36bv+/lhlJTR3abmBJrtT2IL/XzFKKJVEIKjzn4tq0xnCxec1uxWnL8tkxYR46I+f94PTSikdG/cEG1zUfu8u72cPEfiu+p2DLSh8sFZsPhvxFNgTBkc0a7dZCsWwAgRn4jb/43Ymk0MgokVTXCZGPhZKjyZbfpvQ8FZdB/yhXe8lWyRNgrOJMFpADktQ9KFNB6w1iUGIZoOeRL0QFBwaZrBkbrLrTrU2CHhHgYEJ+fglPsfa34caoX1we3tta7c2K17bInlEkiHz0uAYFwmvf8G0mphEI0RpEOltDpVDusEhChe7lXbEil3mZRsXMoXzwQwmi4JyZbHM+Ltp
x-ms-exchange-antispam-messagedata: 67AnwmQEZPjQM6KvJ36n83sjO4GRn6nmxXyjta2cZ+xNiZbpJstl4B6VEyDzhXKcpP3Vo/Br2lfCaDeXdjdnTL5egyBEwNjKfPiR6jxsLFhm0NWC71WsiyjjsyseU4MNUYjB9UPlTNMyjZUkGYPvqQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ef65736-08e4-40a1-b23a-08d7dd863e9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2020 19:34:54.0656
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3a+10QjHD5nrslw6LaZNQLzfSQ8fhluc4acDioNVvi0sIXn3Xi2FrvXy7C1TWnetxtTApiw5Oe2h95Gjm/vt24sWEwxwCg8WU/Cy3mT9qCA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1109
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Andrea Parri (Microsoft) <parri.andrea@gmail.com> Sent: Sunday, April=
 5, 2020 5:15 PM
>=20
> VMBus version 4.1 and later support the CHANNELMSG_MODIFYCHANNEL(22)
> message type which can be used to request Hyper-V to change the vCPU
> that a channel will interrupt.
>=20
> Introduce the CHANNELMSG_MODIFYCHANNEL message type, and define the
> vmbus_send_modifychannel() function to send CHANNELMSG_MODIFYCHANNEL
> requests to the host via a hypercall.  The function is then used to
> define a sysfs "store" operation, which allows to change the (v)CPU
> the channel will interrupt by using the sysfs interface.  The feature
> can be used for load balancing or other purposes.
>=20
> One interesting catch here is that Hyper-V can *not* currently ACK
> CHANNELMSG_MODIFYCHANNEL messages with the promise that (after the ACK
> is sent) the channel won't send any more interrupts to the "old" CPU.
>=20
> The peculiarity of the CHANNELMSG_MODIFYCHANNEL messages is problematic
> if the user want to take a CPU offline, since we don't want to take a
> CPU offline (and, potentially, "lose" channel interrupts on such CPU)
> if the host is still processing a CHANNELMSG_MODIFYCHANNEL message
> associated to that CPU.
>=20
> It is worth mentioning, however, that we have been unable to observe
> the above mentioned "race": in all our tests, CHANNELMSG_MODIFYCHANNEL
> requests appeared *as if* they were processed synchronously by the host.
>=20
> Suggested-by: Michael Kelley <mikelley@microsoft.com>
> Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
> ---
>  drivers/hv/channel.c      |  28 ++++++++++
>  drivers/hv/channel_mgmt.c |   2 +-
>  drivers/hv/hv_trace.h     |  19 +++++++
>  drivers/hv/vmbus_drv.c    | 108 +++++++++++++++++++++++++++++++++++++-
>  include/linux/hyperv.h    |  10 +++-
>  5 files changed, 163 insertions(+), 4 deletions(-)
>=20

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
