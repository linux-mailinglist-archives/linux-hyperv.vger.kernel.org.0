Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06363594E1A
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Aug 2022 03:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239483AbiHPBhy (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 15 Aug 2022 21:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbiHPBhd (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 15 Aug 2022 21:37:33 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-centralusazon11021026.outbound.protection.outlook.com [52.101.62.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB8A33351;
        Mon, 15 Aug 2022 14:29:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GhvIY6YkimvCYXI18ERD4VRy5cRtpyvAjXvubbLC88frR7qHJSdV0w9wq5iy+IG/y74w+5sDCJ22ipmWd0tIy216uX4klkTDcqKz/KoMVExydFfo9og4LztKmzBjcabqzh0eBDgy05OrXLE5IetsLQFx/h4kMvFFxqDR479GbBOzjVjftkJDYJBQ0HySkyFuoxpmmMzxI6WQ7ro2+xxLipgT6mr5baZHOUIaLNk+A8iDyLTwzKjor/EuXgJ+4tFSR3MWoUR1PgGk8SuAfYJEuTU9TMI8YlvhXLYj8belSZYDSY45fuFEyhBESy7ToZrgOLkFdOXvG25QMrRc7jOqIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rZe7M4Zpte5IVuqosy/WtbO5Yfr9gYV+UA1WeGCOfMM=;
 b=K2EjBKcGg0plcGzq48EbMg2LKt93jfYVnyNZJi8hMca8y5P4fgsqKXoR0SEoxbtLUWBbsIEHsNPE04B9qQlR2drzIkyVixp8aGQ1tyx3F/b6xR0LY9Fk3vreYBWoXxfpv620i9yMafNPMuSVKslGmCehn/jbjTk8AcuYGcXvYUGWPkbgB1ENvUjEakao6ChlbfVyTSSuSzFUqiduBa7ZTVKxtdAiVeh8TtDTlrEVdh4LeSWWbX7aMhSYq3Dxfef7NjjvvwbAChyuNoOeYrkrp/aJ94xlZVYcTJ3EP1dQtdgy9iBk85vUEzspACPdRK4Fo6hQspxOC0lFEuKgM7HPMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rZe7M4Zpte5IVuqosy/WtbO5Yfr9gYV+UA1WeGCOfMM=;
 b=LcfWElZBXmyKdu0fT7fX8vcBhFte9RXnSs1iyE+Mm9oge4KhKO86jizrKbyX9p137GmyOSgymmBWBmUcJE2Gjj59snBGR1rdSgWjsG5ol+aqKu2dKCRNJeTAqdFcHrO5GL1cCivsJhNHsOFljP3wNHrzdFaj/Vj+AkM82a8EPbc=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by SA0PR21MB1931.namprd21.prod.outlook.com (2603:10b6:806:e3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.15; Mon, 15 Aug
 2022 21:10:12 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::a440:fe96:e2bc:840e]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::a440:fe96:e2bc:840e%4]) with mapi id 15.20.5546.014; Mon, 15 Aug 2022
 21:10:12 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "quic_jhugo@quicinc.com" <quic_jhugo@quicinc.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        Boqun Feng <Boqun.Feng@microsoft.com>,
        Carl Vanderlip <quic_carlv@quicinc.com>
Subject: RE: [PATCH] PCI: hv: Fix the definiton of vector in
 hv_compose_msi_msg()
Thread-Topic: [PATCH] PCI: hv: Fix the definiton of vector in
 hv_compose_msi_msg()
Thread-Index: AQHYsOac2fMcX0s9O0OiWaZVRKUYJK2wcwrw
Date:   Mon, 15 Aug 2022 21:10:12 +0000
Message-ID: <SA1PR21MB1335D2774A05B3C95233921BBF689@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <20220815185505.7626-1-decui@microsoft.com>
 <20220815203545.GA1971949@bhelgaas>
In-Reply-To: <20220815203545.GA1971949@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=de39f397-b2d6-4df4-a9ff-18924cd9868d;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-08-15T21:03:08Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b7755bee-edfb-4874-dac7-08da7f028ab6
x-ms-traffictypediagnostic: SA0PR21MB1931:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eKOGt6UvaqYMAmHgS9HpkJ9Ei1onhKUr9tSdf7n1EtbyX0nwNLkYkyjmy4zmT9qzUH1IBAaV6HeZLKwAdFvt0oJecVk8dGqI5SDhrD05w4VqiQZhJzwKVUC27p50u2xBKfDi9ZOs1oYZ1JlO9rsZM95Z7iNqRp+T/T89fm/whyJEvuRloXltKA5cMxFUtuWQWPCWSE1wXFyr4486YvjgS487qGkxGvaFsgGnPGfUfttP4/QBNtZrrEbGgWDgBzXwchDmQ9EkShHxiet0mMmbdyjmc04Z1FitnP/GRYGjybXnhxOIpgH5lO2E1lHAG+OwGj6I84qhf//SXtnPbcSLXWne5xfQ+QIR6h1Y0YUswqRmZBuh5RonT+2BoPfcO/mwhvsWQoqZsa2TJCkxdTu+kBjlFxfEGwiMmmcVq2X9AMBuoEFp7hHI5i1dvd+HHtT9cKG4qM9agmYq9yGcP9WJ3Z4eFwFh3/p+NEqT3EBtPVQxa16qPGQeo19pN1YVJjOY26zoGR68v9/cBMgGLXQAmN1lhWMU0VAr6USfUH8MzK2gCEEhhgrcRVJtCD2YupYlg5GJSqEwpuQEwPeNPQ6wc4DnbAA0+7AUJBxmjraqywHh59ltL9YqMCja1SRibcY6vMotL/4a3DnJe8nQcdGNT94izn2QqG5bpWdM9j8eLX8I1+u6L9R2BVQ4uoI7Tiopwn6t8hKewkRziOEZhV2W/MZ2JkTL/LYkk61plRFdUErhWu3OjPBMAFXfwdc3i03KjSu9bLkxHdkSJQC3J7lzKSQfqk7TCdzeBx1uYK3jxpAzbk93LMk1ewLM5XH/6ZIiI8rE80HfON1xhhLzAv3odXgTIGnyy3pQHFM7Hs8pwFY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(376002)(346002)(366004)(396003)(451199009)(83380400001)(6506007)(38070700005)(7696005)(53546011)(186003)(9686003)(26005)(82950400001)(82960400001)(122000001)(38100700002)(8936002)(52536014)(7416002)(5660300002)(8676002)(66556008)(76116006)(4326008)(66446008)(66946007)(64756008)(66476007)(55016003)(2906002)(8990500004)(71200400001)(478600001)(41300700001)(316002)(10290500003)(6916009)(54906003)(33656002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Qx1dFiIQQmwC5Wuz6OmDa4tRAk5OsBIqTrX5TfLX2iz3bf7mWEgh8q/y0e9y?=
 =?us-ascii?Q?hp5Kfpzi+YjD4m3EGQk7ngkXfWJaelM9FPfbLzZMENQRhXjhAnBSmh9Ud2lw?=
 =?us-ascii?Q?dRK6T6Di2S8wvK/Od/7/gWRsytjW+d1OLHGN0Fnos5HuvE5WVhQJPi7uX8nn?=
 =?us-ascii?Q?HD9f9UksirZ1WVKKquqsjG0W9sEIr69PIEOudYm8fKgFKXvkfFia/IhW3Ib7?=
 =?us-ascii?Q?RjnJVnNexaSGKOMP9x47A6cx632lvhtVKBll3/JFIidjSs/geCvIT51qn8b2?=
 =?us-ascii?Q?YKR4wa6KoW/foEOl+WgEZRb0C0yxELtQpPSVDAlY0QjohQlIwuPOu7JCfBPy?=
 =?us-ascii?Q?8S65C37dERqIzRzijYp0LQlKRLBB01HfjWvf9H8tjUMfce/nhq1qWJ3vvv9B?=
 =?us-ascii?Q?B3dy0YsjFmPYtY4x1Uo770c5j2RkjQ+WTR3QnJHiWK/CCjFgzWXe2iUXrtj0?=
 =?us-ascii?Q?knp68AGXROnD5DqWFNfGpueZ/Y2lsbzIgY3mUHmoPoLi1iaEvK88s/QKvkVo?=
 =?us-ascii?Q?qAOJsCAuVS0p3aljMKFaXPVPca6IMrVbRIX36vi03YfAuVhXeDxNw7VoIP6p?=
 =?us-ascii?Q?wz8Jkly1NNGQN4qDkn2ZuNiocAQ1pZKMW36ZbX/IqC95PIyI18iKlhdlzfKn?=
 =?us-ascii?Q?LzdPS59oUNRhbgcV24yrsL9vIAy0QZHcP9F802519eoYG1yYhI3vpTo5XlW2?=
 =?us-ascii?Q?Ia0i8T+SbwXSSPt5W9ASBwzvuwVz1stoqwGKSjAZLQU5GYB4d7SQS7U4e1XM?=
 =?us-ascii?Q?WP7vWw44SNhtyn+YCKcouR8caBfdtTd4BGlEGeFNgML67ShdoUeN5jF+Dhyi?=
 =?us-ascii?Q?Rgbl//ofyw7iwRx9MNVtrOArYucKsIAvWSG7LpaTHmlUT7bi60p4WoHV8lya?=
 =?us-ascii?Q?gFvGB19+0kwuNvRIbSqG2BMJpLh8zzw9oxhb189JOoiJxmOjwnR+iIp+lreo?=
 =?us-ascii?Q?T9WA1arUXUzs/xOIOUxmMxrMAI9caBVVflFhaZ6eFeaY9pi9PwTbXN8gTis0?=
 =?us-ascii?Q?QY/aba6pxsUoMede3VVmKPrPFtz8/S3m54C9eeL3zWqfm/oHo9H4/0VbBvwV?=
 =?us-ascii?Q?ntV13+N1Y49cyMSEQv21Y/85K3+N3GFcvaReWu84gpAP0IJszHZ27x5PqhFB?=
 =?us-ascii?Q?McSAqlizQrEymD6HAnfgSemlNXlCxMGhdUFHoDLuE/xeS2D6Fm3zUyNoFzkI?=
 =?us-ascii?Q?lBI/4Onq6cFmAacQOMbk6f5m8GtjZ/yTmgCLQe2W89bs2iOYiJGm88uI2JAU?=
 =?us-ascii?Q?il1XjA+1yFpPa0e885RvU5FZGuvaX7uZRzYMN2ADqRFXjfeIiSf8EtPZBElh?=
 =?us-ascii?Q?LNKvqGtoTMby1wqBQpAX8qzPhNpz9yj094Q/mALnglQmP5LIAE98MLiJg1b3?=
 =?us-ascii?Q?T1rqceXgcbu4nlO9IoKCHT7s36Bg3BIgMuPKfvUjjEq1USZNkfb6h3UN1nfN?=
 =?us-ascii?Q?dP9NPfZa652MSohFD1B0sc8tzuGozh5BoDGILpLKZhMLTdGfyX7uNtQquXHu?=
 =?us-ascii?Q?HsH2Uop3UkbCUUmrJwNMDZ58Eo91BKiBOaegRRw1cvm34kjTxSYTR99MA25Y?=
 =?us-ascii?Q?oeq2o6+5og+vHHnmPFDgihCYxEPaTNClMP49ZBjS?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR21MB1931
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Bjorn Helgaas <helgaas@kernel.org>
> Sent: Monday, August 15, 2022 1:36 PM
> To: Dexuan Cui <decui@microsoft.com>
>=20
> s/definiton/definition/ in subject
> (only if you have other occasion to repost this)

Thanks, Bjorn! I suppose Wei can help fix this. :-)
=20
> On Mon, Aug 15, 2022 at 11:55:05AM -0700, Dexuan Cui wrote:
> > The local variable 'vector' must be u32 rather than u8: see the
> > struct hv_msi_desc3.
> >
> > 'vector_count' should be u16 rather than u8: see struct hv_msi_desc,
> > hv_msi_desc2 and hv_msi_desc3.
> >
> > Fixes: a2bad844a67b ("PCI: hv: Fix interrupt mapping for multi-MSI")
> > Signed-off-by: Dexuan Cui <decui@microsoft.com>
> > Cc: Jeffrey Hugo <quic_jhugo@quicinc.com>
> > Cc: Carl Vanderlip <quic_carlv@quicinc.com>
>=20
> Looks like Wei has been applying most changes to pci-hyperv.c, so I
> assume the same will happen here.

So I interpret this as an ack for Wei to apply the earlier patch
    [PATCH] PCI: hv: Only reuse existing IRTE allocation for Multi-MSI
and this patch.

The two small patches are pure Hyper-V specific changes, so IMO it's
better for them to go through Wei's Hyper-V tree rather than the PCI tree.
(It looks like the PCI folks are too busy right now)

> > ---
> >
> > The patch should be appplied after the earlier patch:
> >     [PATCH] PCI: hv: Only reuse existing IRTE allocation for Multi-MSI
