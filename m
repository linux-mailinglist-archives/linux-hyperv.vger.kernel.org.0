Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1C2712A6D3
	for <lists+linux-hyperv@lfdr.de>; Wed, 25 Dec 2019 09:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726106AbfLYIqb (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 25 Dec 2019 03:46:31 -0500
Received: from mail-bgr052101135018.outbound.protection.outlook.com ([52.101.135.18]:27319
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726025AbfLYIqa (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 25 Dec 2019 03:46:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fFXs3SRLNZOhFxR9AFbquEpx4LYEGwHnbeq/bqKhTpSt2ulFzhFre8CbZG10ZaJh99EWqqXLlU8ZhgYTClDkPETWLcf+ny9B0NOKAChaZOKBV9LpBx7DWwExVWF0IGgGZNAehgdmS7HvBIJgRwb4+e8x69JtTrFyYRvGDpQ5WVc+pbDOctjHlh1LPMJy2+dW7XH83PuPoyTfAIlA2Aljl/uBI1z5kPlNskN+GrjMjEbrNdbmnSdVR3pp+Fj23Qi1EB1NYfOavj2RrjsL6QQzdNKIVwq55boZJ4pCoA8NqFEgXzhgfCMSL1qCt/GEXkw+G8tnKNihvR2fTu14MDMpuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TffTKq7nBNpLLD5zBFuYoRNa24HFraDVx5XxqzOHrvc=;
 b=kmlC3wPPvy+KUWk9f3XFkAtZpo7YPsAnYf45390kEmxP30LbJ3zCcHqLp99wtw/S+EbN/qHmbMFYvIhASDwC6YTp02Te6HPtnHqBmGK+ACMfGWj59vtzmnS4uc8PzjE5yE2ohR4ldoX9r36Stc5TmCGHcTS7HVmnZEa+UrV8n3NiediXCMunb+t6RKxEmAV1nZuhWzaus/mFIN90P7z5uv4mUSWTmL1xN2ZRahYWXCYCRU3V6mQDUPS+FtBd4/R5paMIL4/+8WzBA2Tmgq4iFMQQJMn1DHxF4+IJIndeCwH5kHlJcDmaLnT2q13chW8qRJT1xF0WPLiU5gHhAobbcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TffTKq7nBNpLLD5zBFuYoRNa24HFraDVx5XxqzOHrvc=;
 b=r7WvxZrLHQUXL7/7HnNUJlwI9WWsIMepALFvDgec7xSKV0fjt78bLj6B7szsAMv1OhVWMMOrwqOwrY0rjRWGAEBoqr01wn56/HDaOOIUm9JRrbx5PFc74LcycNqqyenIonPpUudcgSK4GuXnWuPpu04yx8db6yFYo2qOvwG5iqA=
Received: from VI1PR08MB4608.eurprd08.prod.outlook.com (20.178.80.22) by
 VI1PR08MB2783.eurprd08.prod.outlook.com (10.170.236.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.16; Wed, 25 Dec 2019 08:46:19 +0000
Received: from VI1PR08MB4608.eurprd08.prod.outlook.com
 ([fe80::acb0:a61d:f08a:1c12]) by VI1PR08MB4608.eurprd08.prod.outlook.com
 ([fe80::acb0:a61d:f08a:1c12%7]) with mapi id 15.20.2559.017; Wed, 25 Dec 2019
 08:46:19 +0000
From:   Roman Kagan <rkagan@virtuozzo.com>
To:     Michael Kelley <mikelley@microsoft.com>
CC:     "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: Re: flow control in vmbus ring buffers
Thread-Topic: flow control in vmbus ring buffers
Thread-Index: AQHVuki/5e8dawcR8kGygRTboGxxoqfJecsAgAAYkzCAAPiZgA==
Date:   Wed, 25 Dec 2019 08:46:19 +0000
Message-ID: <20191225084615.GB168681@rkaganb.sw.ru>
References: <20191224105605.GA164618@rkaganb.sw.ru>
 <20191224162832.GA168681@rkaganb.sw.ru>
 <CY4PR21MB06295F8CEE034AD045EEBE79D7290@CY4PR21MB0629.namprd21.prod.outlook.com>
In-Reply-To: <CY4PR21MB06295F8CEE034AD045EEBE79D7290@CY4PR21MB0629.namprd21.prod.outlook.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
mail-followup-to: Roman Kagan <rkagan@virtuozzo.com>,   Michael Kelley
 <mikelley@microsoft.com>,      "linux-hyperv@vger.kernel.org"
 <linux-hyperv@vger.kernel.org>
x-originating-ip: [185.231.240.5]
x-clientproxiedby: HE1PR05CA0161.eurprd05.prod.outlook.com
 (2603:10a6:7:28::48) To VI1PR08MB4608.eurprd08.prod.outlook.com
 (2603:10a6:803:c0::22)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6038271e-a104-4921-f43c-08d78916e915
x-ms-traffictypediagnostic: VI1PR08MB2783:|VI1PR08MB2783:|VI1PR08MB2783:
x-microsoft-antispam-prvs: <VI1PR08MB2783934ACF336FDF53819F0CC9280@VI1PR08MB2783.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 02622CEF0A
x-forefront-antispam-report: SFV:SPM;SFS:(10019020)(396003)(39840400004)(346002)(136003)(376002)(366004)(199004)(189003)(36756003)(52116002)(6506007)(6512007)(6916009)(6486002)(26005)(4326008)(186003)(9686003)(2906002)(66476007)(71200400001)(64756008)(5660300002)(66446008)(8676002)(8936002)(316002)(81166006)(33656002)(81156014)(66946007)(1076003)(86362001)(478600001)(66556008)(30126003);DIR:OUT;SFP:1501;SCL:5;SRVR:VI1PR08MB2783;H:VI1PR08MB4608.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;CAT:OSPM;
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: O8quXRyKXzIMYH8MRurVvbq7qp3mmCxLLaXfdiXyrqJjlP+6WEur7rl0jIT+Iq7LNFlvyrByK5V9Kiv223eiFrgGX/rm+tDIMIlEhOwxkCWFbozouydbMiynds5z3c8yTxhaeyyHNADATCcUl/2AmgJ9tGc5InfK9RLvq0rtkyVccSzsCpP+2CYxAT6Ykr+8M4nfmPu9yxgHDlBqOd1A1wefLzySyN/xNQQ4eWjWZVtAaqaVqZEGJpVRfgm+T0D0V3lDT/+Q2e4l223mNyN7qHVgRdgWVU/rT03L0vrXNLFcXbT7euRBknnXmaqVvfQoN9nasFGkPU47/Y8pLs9rstnqBuseQvubIA6hKCr1YBW/OodTLYY4UiZakUF3Dw6seheYBpoYn6b1NOgkac7WkBQUZJ4HOVfo8TJFcrE9cC0WyigWCgv6uQUOA0Trw7Ln4NS4XwRjuGIBXR2CooACcvlmOq2MCSL4G1923WFWHtqiBRdIoMlPJ4mZf+6WaD1yYkPDomVcAfgQ2OiZ/z74rt8lymp5tZpIHevyET2u6H8FUHe64Uj3RreyeMmYcuwy5QG7rdHSp2pVltxAx2JZqAYGrnK29e/OM7OGtubPpNGY/mNDBtcwG0EWn2Lg2mEjZUbrd44SkFhygfjxRLnkujDydt/jnTB6KzI7l8nn6dycRqmBU5boF0VtBvJBsTMj9jX15dnx0end3wKrfzYVRLam7g0YxTeDpqKjNLwNBctbSgi/1ELfuupOjE0pf3vBcWfXLARKz6F/Ik7tcAxVOA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1C79998B14F12F4782C7B05E24746869@eurprd08.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6038271e-a104-4921-f43c-08d78916e915
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Dec 2019 08:46:19.2058
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GtY3WBM/Fy4IEGrgLngZDDv6Ruyj/dZXUCDyS3YFLe42Mj/LCIVGeLmjQ4CpENyCmSqRrRFY+qwOfZnGS01zsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2783
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Dec 24, 2019 at 06:03:15PM +0000, Michael Kelley wrote:
> From: Roman Kagan <rkagan@virtuozzo.com> Sent: Tuesday, December 24, 2019 8:29 AM
> > 
> > On Tue, Dec 24, 2019 at 10:56:08AM +0000, Roman Kagan wrote:
> > > I'm trying to get my head around how the flow control in vmbus ring
> > > buffers works.
> > >
> > > In particular, I'm failing to see how the following can be prevented:
> > >
> > >
> > >      producer                     |       consumer
> > > ==================================================================
> > > read read_index                   |
> > > (enough room for packet)          |
> > > write pending_send_sz = 0         |
> > > write packet                      |
> > > update write_index                |
> > >                                   | read write_index
> > > read read_index                   | read packet
> > > (not enough room for packet)      | update read_index (= write_index)
> > >                                   | read pending_send_sz = 0
> > > write pending_send_sz = X         | skip notification
> > > go to sleep                       | go to sleep
> > >                                 stall
> > >
> > > Could anybody please shed some light on how it's supposed to work?
> > 
> > Sorry to reply to myself, but looks like the answer is to re-read
> > read_index on the producer side after setting pending_send_sz.
> > 
> 
> Are you seeing a problem in the Linux guest code in drivers/hv/ring_buffer.c?

No, nothing in particular.

> The only time the Linux guest as the producer sets pending_send_sz is in the
> hv_socket code.

Indeed.  This surprized me somewhat, but, well...

> Or are you looking at the KVM code that does emulation of Hyper-V,
> where KVM is acting as the producer?

Yes, at the QEMU code, more precisely.  I wrote it a while back and now
have some spare cycles to at last submit it to mainline QEMU; while
reviewing it I noticed this part that I did wrong.

Thanks,
Roman.
