Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99E65551FE0
	for <lists+linux-hyperv@lfdr.de>; Mon, 20 Jun 2022 17:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243157AbiFTPJd (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 20 Jun 2022 11:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241048AbiFTPJT (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 20 Jun 2022 11:09:19 -0400
Received: from na01-obe.outbound.protection.outlook.com (mail-bgr052101064019.outbound.protection.outlook.com [52.101.64.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF9102ED51;
        Mon, 20 Jun 2022 07:54:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GgzbCL4sMMSOb1V7b13dNp7PenRWWKnvajBQZfeRlwRpKUPgCZ8o5izDIM3fBxWLwDScOc0FUo3OcMINwCb86gd1YhTVutVQ+KC+198VvWN0DqNXIz9fJ/K8ED5Ssoj13bkSvJv82fGlV7WR2LLIrAAe5scok7w8fxJxYnhIzMN3ERy4uZRQoMqpnKP7jN1JIVp7EKYrvpUWt/3aTirrKDes0sJkchGSE+UgFNwLoZn++OEag/eq3ZKSJ/3/EPEkFm2EMgLOrCwRTyG3DM0/xM3xaVZY242C4u6sE+ngeChdtKxz7hKonaWQwZuSy17FBlzB6joARLlvrOUn/aQYhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JE1L7p6+v8mLE1AOj8i3nJl5+Kf1xiNGypOdKnTBHxg=;
 b=YnvonaXIW9KYt9E8EVaJkGmNtqeVnHKK3jGTc/5TmqwMldX1ZSDCJDSUilb5TXw5mlRy6XfB7gVtrzkRWOP16/yh7CBP4GroiOQPbMR2T5JfSNX4mjshLKV3oZ44SIQg84VvDq5b4D8t6U+fb9YGbYNcYGrMEGz2zoQpv7MgbA4QMTNQay8t71KmMN1y45u43kye/x9kHdsvqxmwLSqTa32ZRs3d7DQeJQm5fWhJe0PtPYLywlMLcYncs9AVNiGU1PibL9oJTe1GJH6+QctAO8MQbn7NKiXRgmw/6TVjh1JfO25emocL2gHAUtwz73raLdSlGxDRuRmijCVJi2EJUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JE1L7p6+v8mLE1AOj8i3nJl5+Kf1xiNGypOdKnTBHxg=;
 b=M8+UAHmRISFhvAXj99npsfOFAzAbf0sIoqSarb7aj0s8O3VY5Va7k3/5C+PmXIJJtK1hGReU1Ye70pR36oK6sLDHHi3H9VIhi3Yt9mB6M8yOpV8cgHEEZvjVHi5Cw5/r9+/ij3ZGk6fbGOHm0BGTNHp5DUdqq6eq6lB4SlF8Fx4=
Received: from PH0PR21MB3025.namprd21.prod.outlook.com (2603:10b6:510:d2::21)
 by PH7PR21MB3357.namprd21.prod.outlook.com (2603:10b6:510:1dd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.12; Mon, 20 Jun
 2022 14:53:58 +0000
Received: from PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::500:c4f0:976b:ee74]) by PH0PR21MB3025.namprd21.prod.outlook.com
 ([fe80::500:c4f0:976b:ee74%2]) with mapi id 15.20.5395.002; Mon, 20 Jun 2022
 14:53:58 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Vit Kabele <vit.kabele@sysgo.com>, vkuznets <vkuznets@redhat.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>
Subject: RE: [RFC PATCH] Hyper-V: Initialize crash reporting before vmbus
Thread-Topic: [RFC PATCH] Hyper-V: Initialize crash reporting before vmbus
Thread-Index: AQHYgY7+aXRFT4ZJvEmYPzeeOLzHRa1SIUsAgAY2cwCAAA380A==
Date:   Mon, 20 Jun 2022 14:53:58 +0000
Message-ID: <PH0PR21MB302564C8AC6C3B4F0153A596D7B09@PH0PR21MB3025.namprd21.prod.outlook.com>
References: <YqtAyitIGRAHL7V0@czspare1-lap.sysgo.cz>
 <874k0kirbf.fsf@redhat.com> <YrB8Xvjp2KKQ/JhT@czspare1-lap.sysgo.cz>
In-Reply-To: <YrB8Xvjp2KKQ/JhT@czspare1-lap.sysgo.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=080170ba-6a13-4789-8d24-7c42a15f2085;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2022-06-20T14:45:45Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3d8ccc0d-73a6-4e34-0bbb-08da52ccb485
x-ms-traffictypediagnostic: PH7PR21MB3357:EE_
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <PH7PR21MB3357BCFA5C2477FEE1C4CC1FD7B09@PH7PR21MB3357.namprd21.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v72x6dmISxrQVWfdgQnH/H9abWli95sKOaZMJO31wBFbVZeQ/tSq0svgcr5vgJ7xGuKBoZUrR0dPmIjpWJavPsrWjhY4WHLFEMv9Vp1yV3fjXJLxjZEvCOZCjy0sVLDBPBXaVYgBK2TMKJ5/lYicOSIakp+iD3fRNcGkocDIwMGbK1ngUL44gooW4i6p2QICND0x0AcFz0qe5cDbGjmdQEzeZGjfDyYJJHRNnJktkQo2vN1IDrYOyGWVpzNcdNk9wfY9rSsVfmU0gvtdStDRzc6kD+QBq3/NJpJoz5NzymrWosrYnTWkvP+9qOrzHfWoxGMq+3mgf9wXgzeW6utTQkTWTn8OB/Aw+Gj4xBAxvZLCzD0Dxr+RNcoVA0qh9qkx4uba0HaPrQ1MuIptRvC8yqjiCfB6qshX8ZcmbSK4VsKVSh0GfZiY44BS8F95E35f6cXmFnm08p5Z18xlMLw1lbOCN7NxiCmNNWtq72qoslakexPBDrxhzH4pMD33tSE3z7gF2Kz5fTddOze5P8XQ8diEPm4l559xMoXPrqSeEJ8bKdFXvFgHq10m81tS6dAoN81qmlYYdtJDk19E65bkq0e6o2a2AQVPRCX25S4kx9lNPs74tsqx9YzHo9UHwmopsEpUP3P4xAhsNGJUZ7OTIyxGZtV2uBYSd727QQvT2YOQCXjBCKg7qnv0V85MXlFI4SsEIfY/bSUJpZBPoXKOot7F4aloMeDSCPSpWIdsJq3ol09TMaYO2IvuVDs05PTqGzUs/e0vCNq265XAFEhKeql8QN2EmRhGu0GoKyTqWtcufVLSYdBMqjkfvAdXaTtI/m0QE76pvhXBitEv+LisNl0T0dj7GwoqMzKnxfyZKPapGWK1Z/E7KteL1lN7kY8j
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR21MB3025.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(346002)(366004)(39860400002)(136003)(451199009)(86362001)(26005)(9686003)(8936002)(478600001)(71200400001)(5660300002)(82950400001)(8990500004)(8676002)(54906003)(33656002)(966005)(2906002)(6506007)(52536014)(7696005)(41300700001)(107886003)(66556008)(76116006)(66476007)(38100700002)(66946007)(64756008)(4326008)(10290500003)(55016003)(66446008)(122000001)(82960400001)(38070700005)(186003)(110136005)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?71vd5WuTiEBb3eUtiQ7yAsyv8/reMQ48XbMxhHSFSXIgNQtlGYz2PbroDEeD?=
 =?us-ascii?Q?k5TJEZy4rXY/aPRtpC+pm1uV0qifD9c/mp8NIZsboNAtnwhpK06UOP6U3U6A?=
 =?us-ascii?Q?d/2oh2/eNjAubI1MLSEvCx4QFhScpDNupbSomlqUD9qvoEb7MGfs2yxGtGl/?=
 =?us-ascii?Q?YQFgkuXkREuOZv1RMHqnnU6DRnhJEJr8K/kmbzTchpvB4lZYS98yJf7s9A6h?=
 =?us-ascii?Q?NfgCvakP0XkpcIA8v07BjRVN101YYhbPXeQvp4BVE+jx1k7lP2aIuOBK8gKM?=
 =?us-ascii?Q?MPTbSwdPYm7n8LHVFgViWjx1XBfGXA9G+KEuy7vY0MizMgIuy98yG9h4eEp8?=
 =?us-ascii?Q?KRzQeGGmQTiT4ojaBCXN7nwGQvJrcRg9W+dRtD7CjBwHpJm81OSsFIMs4Xri?=
 =?us-ascii?Q?un/VigHrBSTIubHkUeInKh/3uyJTYy2gnPEuYdQTNVlG3HfPVXY64dgiceRq?=
 =?us-ascii?Q?43bPtjK/o2fpUoL/XgsH5tmR4zS6CJ87axceX6ZiRt255ugvsbB411Bk7Vkv?=
 =?us-ascii?Q?FM1oJd4jGiI8vxyrq3+M5/G4Jl3AOpeHBVTw5NNq3F+SzNScWgFTDSN/PKRE?=
 =?us-ascii?Q?9QnAOiLNBDC9fq3hFPHNfcgbWlomH1cqCtaOgmNL4QER57wCexPXjylhJa66?=
 =?us-ascii?Q?DR/mSas8eJPUhk5cLJQmaRqMjDxX7W1NBrN0cBgxmMuSo/f28ReTS8AQQ+na?=
 =?us-ascii?Q?ZYy0tcgZaL6X2Qb8OXXtNIzlYAGaewIefJI5Ynl5Tath/Hpba8wmjsWYwjR2?=
 =?us-ascii?Q?82+5TG/+tOgHzjtrNEVrODjUhUX7E/whJfQwYcLyQOCunJFNiOQmyO+5X/ez?=
 =?us-ascii?Q?4JSey2fooID/z+/3spJt0QMVvKxc9tfKte8WoXFzhCizry2gBascZxbLg1dt?=
 =?us-ascii?Q?Qidw7Y6BDCZZ4IjshoQvAoRra0qFYK05zXXpeOuiEtbfMt3sUtCYwhQZHt0+?=
 =?us-ascii?Q?HrSuA+VqkDJCZNfg1CManvVvw/uOtciwtafJ+pIG6Y1knMH2UECLd/fGZyju?=
 =?us-ascii?Q?t/Gva6Y0wXa2KIkHR8vgpZCOvk23MqlNuSF1hmTRW9COU1g3gnVZi0SAtyRO?=
 =?us-ascii?Q?4pBQe/kjMlltWaP8HaotNmvCB8zYdOjEXBmhx+jayCE/jeOGOPYTriCx07mT?=
 =?us-ascii?Q?hahAMfGuw28iV9clyIXpRlqJ2s8zCpVonZP8GTS8EapuBX6ZIe5yA0nm99zL?=
 =?us-ascii?Q?UkFYiVXk3V/x3cnWqVTxwdLXFOs295cPumxz7IBMnvaEdd1fG4WTtR9j5PnX?=
 =?us-ascii?Q?rokImmd2Pz+sQWFXB0/yeyLrFwRykfTq5WQcvmwCinu+EWy21MLUQGqTZUQg?=
 =?us-ascii?Q?+G19YkkV2qFPvz5wbWZzQA7hTAJAioeL2X7foA1mYFa90+/RTEgZ5eAo8V1N?=
 =?us-ascii?Q?IEVyNJ2EBm1/1iUXGngJ8bxEDN1l58PUZ4iD4/4k8Oht3op++1XX6Lba1tf/?=
 =?us-ascii?Q?/NH8e+0H1f+gaX+NvnIpF5xsGbMCfsdzQ3xZab5D78d4aDvyZQ3X5OONbXXJ?=
 =?us-ascii?Q?DcUOm2fPp54XRBp06t1yhDO36J6OhZ36pjy2HZIXP31IXqvLnnJbGdTxZ3xU?=
 =?us-ascii?Q?sw+DsYLdExgfPnuJoyjBndY0t4MPwaf22xSwyqMkPqAlPP7o+Vewm+tFzxur?=
 =?us-ascii?Q?x+xN1gUiWM/Xqfs9RxAk+x6qu9JFg1iH5jCP7GFJHjmSoxq2AH8rR3lkVTja?=
 =?us-ascii?Q?S6obe8CRv4EYL+vyBoSLJPOYFmyd07/3PyxEZ5MxziLbqXjqNpZ3kIHanNjN?=
 =?us-ascii?Q?/QOui8+LB2nRshlYtGvedFINdaiq6qY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR21MB3025.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d8ccc0d-73a6-4e34-0bbb-08da52ccb485
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2022 14:53:58.1301
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uOUIn+6d60Cnu1+r5nO29GctprfNJia7hUZulyR7Bh2gg7B9GhfeWVkMzc1EJpxMytHMKeBvFyAmsKEatJ8r7ADEFtme5qGZIrtae8I6e18=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR21MB3357
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Vit Kabele <vit.kabele@sysgo.com> Sent: Monday, June 20, 2022 6:56 AM
>=20
> On Thu, Jun 16, 2022 at 05:03:16PM +0200, Vitaly Kuznetsov wrote:
> > Vit Kabele <vit.kabele@sysgo.com> writes:
> > > Nevertheless, I am not sure about following:
> > >
> > > 1/ The vmbus_initiate_unload function is called within the panic hand=
ler
> > > even when the vmbus initialization does not finish (there might be no
> > > vmbus at all). This should probably not be problem because the vmbus
> > > unload function always checks for current connection state and does
> > > nothing when this is "DISCONNECTED". For better readability, it might=
 be
> > > better to add separate panic notifier for vmbus and crash reporting.
> > >
> > > 2/ Wouldn't it be better to extract the whole reporting capability ou=
t
> > > of the vmbus module, so that it stays present in the kernel even when
> > > the vmbus module is possibly unloaded?
> >
> > IMHO yes but as you mention hyperv_panic_event() currently does to
> > things:
> > 1) Initiates VMBus unload
> > 2) Reports panic to the hypervisor
> >
> > I think untangling them moving the later to arch/x86/hyper-v (and
> > arch/arm64/hyperv/) makes sense.
> Ok, I will send the complete patch soon.
>=20

Vit --

FYI, there's a large patch series [1] that proposed some reorganization
of the panic notifiers across the Linux kernel.  Patch 16 of the series
splits the Hyper-V panic notifier into two along the lines that you
suggest.  In addition to the patch itself, the comments and follow-on
discussion are relevant to changes you propose.  See my responses
throughout the series.

The author of the series is planning a v2, but he's out for a few weeks
so there will be a delay. [2]

Michael

[1] https://lore.kernel.org/linux-hyperv/20220427224924.592546-1-gpiccoli@i=
galia.com/T/#t
[2] https://lore.kernel.org/linux-hyperv/20220427224924.592546-1-gpiccoli@i=
galia.com/T/#m3c190913bcb6f66e3ace792b4e6f2236839d4fa7
