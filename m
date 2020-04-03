Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3273C19CE60
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Apr 2020 03:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390134AbgDCBw4 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 2 Apr 2020 21:52:56 -0400
Received: from mail-mw2nam10on2112.outbound.protection.outlook.com ([40.107.94.112]:17805
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388709AbgDCBw4 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 2 Apr 2020 21:52:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UJlke9gJKhVITFfvbhBH8wpi93NzO+ggA/YBW85WOWTsf644L9Y7QkvbRcPFTC9O4/EJCSU+cHQzmDWKSuzOwCRizj2QJHnLyoikfL0U0zlT0d9njJIh6NDWBDIBGKN5nINapvyFXaFCUELeML0kxFOEmxtJS4V7tBRjrj7gSQBCmMfrYKvaUgz40dSKra2C272c2L/4j57ZSZtQEPihpIQG5A9l2OmPThlH5MSZkOdERE1LXTpKmcEYjetQLbU2OMS83NpQvtM7VFF5bGRarQsffaKNvxh6ROTejbnGiNRntxSdkbd5qxtF+qpTLnBGXwnY5eLuQfKCCuqwgPDLNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8HdstSxiI3/9uOhbBfcmhTBvebxsUwEJVVmr+Hv//10=;
 b=KRxKBLU6aAz/rXwugpKoNBP5BrG9dKKq+ujznpx8wx8EkxM296STQSAFJHrf9diYIPxhHNpkX0ORrNfkIwm/wMryQRFjSu19MLcquQp6jqOQMt230C37tg1RtcKSw+Qi8xU+YGaDg/K5lwL/MbtuuRb47rx76Snvpdwd1HBqzWxYUEyh/MaMJ4yzRDPxXc0sRwRe896nmJJFrRz8mebqbrPsnOrugi5DJccCgpc7V/xYNMKpKBijFKLIQpD60l59y5154tQD8Cmwn/E02F1Z29rKj+Q09Yh06sMBGIz8fMBKTbuupCotMLvXoqPTdr/M29zJop7HHVAIgh6Vi9dpEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8HdstSxiI3/9uOhbBfcmhTBvebxsUwEJVVmr+Hv//10=;
 b=bcDU6crkLQ8ky/Q2Ria5U3ZO3VIt2rT7ItNtALWRDLoHFKu0bdz/q9ndaazsu1di3pCvRC7PI1rAspTLDNddvTpkElOksfiN6KEHH7lm6mVQbZ0N6NjmObvgeh2loJOA1WYkf+qhS8lnfTWnDbFey5Fz8Do/++EN57rVBwW5tW0=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MW2PR2101MB0938.namprd21.prod.outlook.com (2603:10b6:302:4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.2; Fri, 3 Apr
 2020 01:52:52 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156%9]) with mapi id 15.20.2900.002; Fri, 3 Apr 2020
 01:52:52 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     vkuznets <vkuznets@redhat.com>, 163 <freedomsky1986@163.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Wei Liu <wei.liu@kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: RE: [EXTERNAL] [PATCH 1/5] Drivers: hv: copy from message page only
 what's needed
Thread-Topic: [EXTERNAL] [PATCH 1/5] Drivers: hv: copy from message page only
 what's needed
Thread-Index: AQHWCBFy4Pcuq4fv5kyp/xaD3HRdvahl6vWAgAAb8ACAAJyF8A==
Date:   Fri, 3 Apr 2020 01:52:52 +0000
Message-ID: <MW2PR2101MB1052836B9357770FBE0C3825D7C70@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20200401103638.1406431-1-vkuznets@redhat.com>
 <20200401103638.1406431-2-vkuznets@redhat.com>
 <3ed15a02-0b86-0ec1-6daf-df94f8fc6ba5@163.com>
 <87a73tzwdv.fsf@vitty.brq.redhat.com>
In-Reply-To: <87a73tzwdv.fsf@vitty.brq.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-04-03T01:52:50.8421884Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e7978a81-414e-4973-8fba-77627504d013;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 708d54f9-96ab-4a2f-41e4-08d7d771b8e4
x-ms-traffictypediagnostic: MW2PR2101MB0938:|MW2PR2101MB0938:|MW2PR2101MB0938:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB0938127BEB96C10A2E43BFABD7C70@MW2PR2101MB0938.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0362BF9FDB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(376002)(136003)(366004)(396003)(39860400002)(346002)(4326008)(66946007)(9686003)(186003)(2906002)(52536014)(26005)(86362001)(66446008)(5660300002)(66556008)(8990500004)(76116006)(71200400001)(66476007)(64756008)(15650500001)(82960400001)(54906003)(6506007)(10290500003)(110136005)(81156014)(55016002)(8676002)(81166006)(7696005)(53546011)(33656002)(316002)(82950400001)(478600001)(8936002);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z0kd+DMu9Rg4889jt3JyZDlsQIMtA/eTBX4EBgHeKIhd5OQk4DULtUeUVmKc/H03vBh5Pd69CWwzNRXy1xD3rmelpDJBqjzDNQ3A9DAf/262KBrINApNvvOn/eszfcCDXGHhc3hsjQswEpbT7/p3QF37Cnknt1SZHfnDkJkwDkvvHJET7GPQ9t/MIFDs231ZiKryLLyCQ6wC1n9Xl58DY6lEL9B1JtVdGBs5wYml2Np2Ya55DFVqwEDyxX9+692DOkP1tJcocM8qsLXPNJiqUT19n5GGJldOEtnEA10fXCwq8l9eIXkBq15dfSEHpIPYWit94wnKPqWbxj/yIwTakiG4Iokwdn6oY6DXeJ/t7Mpas3LYjDvo26AV1cDzbMDUUAPs/UkzGap6Q18jE0Ump4tqWM3mvBGxHA42aZmIzCaa9+gNf645efGolJVV7r0W
x-ms-exchange-antispam-messagedata: OzuNKBogRNYR9p/9jPovqDosfsvcjEk00NC+iR8olh9T7M2NqGuDlbiECwlE409r6O+9evcaQyu3nnPFJZSAosATDZgsrc0ET3/8knc6UBBGezJrDa1V6gd4qoJKEWAWKzX3T/SIkGzwUknlftIeUQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 708d54f9-96ab-4a2f-41e4-08d7d771b8e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2020 01:52:52.7638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SyCpZUbmQsn4qut76ekzxIrzmG7b5Lxqu5YJkhQolBOed7nJD7FOMuOm22WSY0NyRZkcHRRJKOBzVMAaQcq1F/VZbJKUA59wDKs2qRmkC/g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0938
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Vitaly Kuznetsov <vkuznets@redhat.com>  Sent: Thursday, April 2, 2020=
 9:27 AM
>=20
> 163 <freedomsky1986@163.com> writes:
>=20
> > On 4/1/2020 6:36 PM, Vitaly Kuznetsov wrote:
> >> Hyper-V Interrupt Message Page (SIMP) has 16 256-byte slots for
> >> messages. Each message comes with a header (16 bytes) which specifies =
the
> >> payload length (up to 240 bytes). vmbus_on_msg_dpc(), however, doesn't
> >> look at the real message length and copies the whole slot to a tempora=
ry
> >> buffer before passing it to message handlers. This is potentially dang=
erous
> >> as hypervisor doesn't have to clean the whole slot when putting a new
> >> message there and a message handler can get access to some data which
> >> belongs to a previous message.
> >>
> >> Note, this is not currently a problem because all message handlers are
> >> in-kernel but eventually we may e.g. get this exported to userspace.
> >>
> >> Note also, that this is not a performance critical path: messages (unl=
ike
> >> events) represent rare events so it doesn't really matter (from perfor=
mance
> >> point of view) if we copy too much.
> >>
> >> Fix the issue by taking into account the real message length. The temp=
orary
> >> buffer allocated by vmbus_on_msg_dpc() remains fixed size for now.
> >>
> >> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> >> ---
> >>   drivers/hv/vmbus_drv.c | 3 ++-
> >>   1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> >> index 029378c27421..2b5572146358 100644
> >> --- a/drivers/hv/vmbus_drv.c
> >> +++ b/drivers/hv/vmbus_drv.c
> >> @@ -1043,7 +1043,8 @@ void vmbus_on_msg_dpc(unsigned long data)
> >>   			return;
> >>
> >>   		INIT_WORK(&ctx->work, vmbus_onmessage_work);
> >> -		memcpy(&ctx->msg, msg, sizeof(*msg));
> >> +		memcpy(&ctx->msg, msg, sizeof(msg->header) +
> >> +		       msg->header.payload_size);
> >>
> >
> > Hi Vitaly:
> >       I think we still need to check whether the payload_size passed fr=
om
> > Hyper-V is valid or not here to avoid cross-border issue before doing
> > copying.
>=20
> Sure,
>=20
> the header.payload_size must be 0 <=3D header.payload_size <=3D 240
>=20
> I'll add the check.
>=20

With this change,

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

FWIW, all of this VMbus code, as well as the drivers for the VMbus
synthetic devices, make the fundamental assumption that Hyper-V
is trustworthy and doesn't send any malformed messages.  However,
starting this summer we will be submitting changes to "harden" all
of the interactions with Hyper-V to no longer make that assumption.
All relevant fields will be checked before being used so that incorrect
memory references aren't made.  This patch is one small step in that
direction. :-)

Michael
