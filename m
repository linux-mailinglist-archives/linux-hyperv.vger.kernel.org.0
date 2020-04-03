Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA7819CE75
	for <lists+linux-hyperv@lfdr.de>; Fri,  3 Apr 2020 04:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389507AbgDCCAn (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 2 Apr 2020 22:00:43 -0400
Received: from mail-mw2nam10on2134.outbound.protection.outlook.com ([40.107.94.134]:45558
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389366AbgDCCAn (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 2 Apr 2020 22:00:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S99pxtl/AggvLBlJvllEHfWG7A0m+win5Gtp0/cvosAnS80xRjuksRTyuuAvVYrOPucaXeOF3vU8J6tR5dGMUcdOs9dajfg9BE9ZEqviL51/tkx8SAiZ3XEVmsCx334tdmwcJ2JkTjowS8vUw28VPIgVZgqXKS4FngDvpX5DgAIN4LhSgu8mulcRvzakEsCjKIeofTa/C4YEx5Eo0jjyJk8mbRbF+ryFSVdV6n6Yg2Wa+aHMR8Rcls16NePr3Hk5G/rYy97Oveurm4p6H76GdGdyesIfP8fgQ+VtNgpW15NYcb9n0zxMkYNBRFWVFItlR4rrgIkYKLkRT++JMmCI7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i95rcy8FzpaASpHAeghdFvS3+WNICawHJ1s+51xb4RI=;
 b=G9bYYq0UG0IJlNWWvX2pSP6ysIbyJOw3eC2MN2WVTdsvpw6qhwAb3kJNwZQlD2ycG7FLf3qL9VhguUg6x8iXUl/0rHZB1NXBPzM/zRCde/DdmXXFtUx8hTEf6Hc3ZL9BAZdAXH5CgvBlvC3zO2enOfFVriQiX2wZPlq3EW1VCzK5rVJRcH5sqvCnoWvS+S7mc5Bnu608EslhW/oLSd/us7iyj8R+AFBiS7e5txr+qLnIGQXcf9xiyLXfwcF5amPCj6yJBiwon09lBNSpvWFx32F7sjqy8n86qLPT8Ql36SdgrqtU7n62IKNcJ3cXjzeO/WiVDjtumb7Dxf2cjt/xaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i95rcy8FzpaASpHAeghdFvS3+WNICawHJ1s+51xb4RI=;
 b=SpVhdvSElPmPzoaUJJCNqsWNilHD2Av1ilNetlsIAZGUr8xuIioJVVH5MiZjoJtvnE+uFDhYJYrpNCppYYD+EGAz8fXMu5Gzj3DM9lXXNNDEpLQZtmoimU7lvJgU16HAvzYKIPG0uzmnCON2k71OQ2PTMbVDGEL1Rwq90sFCVCA=
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com (2603:10b6:302:a::16)
 by MW2PR2101MB0938.namprd21.prod.outlook.com (2603:10b6:302:4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.2; Fri, 3 Apr
 2020 02:00:02 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::71ee:121:71bd:6156%9]) with mapi id 15.20.2900.002; Fri, 3 Apr 2020
 02:00:02 +0000
From:   Michael Kelley <mikelley@microsoft.com>
To:     vkuznets <vkuznets@redhat.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Wei Liu <wei.liu@kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: RE: [PATCH 5/5] Drivers: hv: check VMBus messages lengths
Thread-Topic: [PATCH 5/5] Drivers: hv: check VMBus messages lengths
Thread-Index: AQHWCBGsObmTW9nyeEOZJAD7Y+XV+ahmpgTA
Date:   Fri, 3 Apr 2020 02:00:02 +0000
Message-ID: <MW2PR2101MB1052E7B2458F489E0123C1D9D7C70@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20200401103638.1406431-1-vkuznets@redhat.com>
 <20200401103816.1406642-1-vkuznets@redhat.com>
 <20200401103816.1406642-2-vkuznets@redhat.com>
In-Reply-To: <20200401103816.1406642-2-vkuznets@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-04-03T02:00:00.6095388Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e471e7da-d48a-4361-bfd5-9a032b461263;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=mikelley@microsoft.com; 
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5cb0b8d1-4aee-4a9b-1c4b-08d7d772b8e6
x-ms-traffictypediagnostic: MW2PR2101MB0938:|MW2PR2101MB0938:|MW2PR2101MB0938:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MW2PR2101MB09386C9FFE340B3E2D8DB9AED7C70@MW2PR2101MB0938.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0362BF9FDB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR2101MB1052.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(346002)(39860400002)(376002)(366004)(136003)(396003)(6506007)(10290500003)(110136005)(15650500001)(54906003)(82960400001)(33656002)(7696005)(316002)(478600001)(8936002)(82950400001)(81156014)(55016002)(8676002)(81166006)(66946007)(186003)(9686003)(4326008)(66556008)(66476007)(64756008)(71200400001)(8990500004)(76116006)(26005)(86362001)(2906002)(52536014)(5660300002)(66446008);DIR:OUT;SFP:1102;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w7VlTTz5IWdWlGKfO3ry83/FS+6hoq9CJtWl8SvjGmDIGh1lGjOsSk+i31eyYM5K5Tsh+12JPD0DBZ/XEMUYYWucUrRVCMfKvuD6Hxg7J9H5gthDv1I8jkfKH4KmoNVVbG72+xJQ5ToAJFTw4zb6AnPSJsKHEg3IZkHPzvhmGdhvVtaJQNOpsVorQyOvMAqmVxEjTGmEeTqSI4KiYVGjaEp1DJbNfJWfbTUn977t4kKeueWVjIaqgFj5swAzV1G3CnXdgbu4jLLVoHiGCQQDWTtDgreBbeAFhbtndjFxAjy2fETDn7oHRNJmmgP8UW1gx5Ta2U+8QeNn5FbakS1l9dTOsnQrPY7SJTAcIrXb61Ejs+gZ+UMK4cJZId79RFWlky9nCesol3NfmLQ8zSPg04glXkOyA6zUdYIiUZpMK0nlfQknMSGy9+UaUj4v2j5k
x-ms-exchange-antispam-messagedata: d+1r8Ykk7awDYXC2s/S7BAZNjdhDF7FtpSIzmTCUI5h49lbl5ZvkZJpVMOqvyN0u7fZUEmGa0OKqf1vlKev1A1As1p6D0ws7LYlPI69iy5TwBD5dlDNOVvTDmWj/MjHCS8ZPcr4ur3/jb/f3M24yvA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cb0b8d1-4aee-4a9b-1c4b-08d7d772b8e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2020 02:00:02.1448
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hxn1OaGukmUwSiLMYVkqZ0N6qjCiKdOZDYD9GuhZvDeOSrtc///oJrLpneGmHIg1WQmEHykG0S22jJuHSL/aO5FCQ+6tM1U++Q1+8fuJ2Wo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0938
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Vitaly Kuznetsov <vkuznets@redhat.com>  Sent: Wednesday, April 1, 202=
0 3:38 AM
>=20
> VMBus message handlers (channel_message_table) receive a pointer to
> 'struct vmbus_channel_message_header' and cast it to a structure of their
> choice, which is sometimes longer than the header. We, however, don't che=
ck
> that the message is long enough so in case hypervisor screws up we'll be
> accessing memory beyond what was allocated for temporary buffer.
>=20
> Previously, we used to always allocate and copy 256 bytes from message pa=
ge
> to temporary buffer but this is hardly better: in case the message is
> shorter than we expect we'll be trying to consume garbage as some real
> data and no memory guarding technique will be able to identify an issue.
>=20
> Introduce 'min_payload_len' to 'struct vmbus_channel_message_table_entry'
> and check against it in vmbus_on_msg_dpc(). Note, we can't require the
> exact length as new hypervisor versions may add extra fields to messages,
> we only check that the message is not shorter than we expect.

This assumes that the current structure definitions don't already
include extra fields that were added in newer versions of Hyper-V.  If they=
 did,
the minimum length test could fail on older versions of Hyper-V.  But I
looked through the structure definitions and don't see any indication that
such extra fields have been added, so this should be OK.

>=20
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  drivers/hv/channel_mgmt.c | 54 ++++++++++++++++++++++-----------------
>  drivers/hv/hyperv_vmbus.h |  1 +
>  drivers/hv/vmbus_drv.c    |  6 +++++
>  3 files changed, 37 insertions(+), 24 deletions(-)
>=20

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
