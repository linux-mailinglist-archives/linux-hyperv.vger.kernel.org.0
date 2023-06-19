Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53440735D21
	for <lists+linux-hyperv@lfdr.de>; Mon, 19 Jun 2023 19:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjFSRl2 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 19 Jun 2023 13:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjFSRl1 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 19 Jun 2023 13:41:27 -0400
Received: from BN3PR00CU001.outbound.protection.outlook.com (mail-eastus2azon11020024.outbound.protection.outlook.com [52.101.56.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62070E0;
        Mon, 19 Jun 2023 10:41:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RQXaqLwVO81OcT1E4Y+jzqujqBfxQQ7sK7uc9yYwzm3ze57C0B9UuENX4ZHUWnFbJbA92j+C4Z7qWOuMtfW/pVury3m54CUkkJcIThreAPVBHzcaugO/PUnYBsgu1H44YoJ9cnKcbzlMwemXSjasCqphBkrQEeWH549UvJmbBHs90nU9LsAQ05eREZoUY4V9OsodDp9VqXJVZndLt0LJ0t/JhVV9FK/vOBmpwDbd0FUZOwxti09/CfK8AKFcKOhTQ5pvvru0fcy7B8CWdHKPBDybzuEPXD3QFPEtb8NfMovOHXisuVAahrkkHoifDkygqpEe7s0Ed5XNhkQs1mZIug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SKgNK+XyPhNtnI0XAKINLSXON4dyFQhDlXCo90KgeTU=;
 b=iDIGgQeoyN7XSlfbW2Z1JBWQgc5YZi9lG1gPhy0xpX7x1y2L6U4DnTy/UikSO3jpRLlqzuyeDpN7zvbrxGUVM/UCTwUSJtAXANgfn+xkIIeSPTxVorUYioUDtziwPXxD1ROOdtR74X/AwU/kB0jjSupNCgkLtd0MngiXeRv4mCrClp3zLXpuS7VMP5IlZewT1V7+vxDbd4eKAdwwlyqLcUgP3A97ur2kvrc0qDyeXhPwaB8aPtOHT8xhkHelV9VGHdZtCWVe7xO9oI/KJ958y+S3i2+o5JxSaxxvYZmATqopszHgAVLQJxtGUbvJ9spQYcxlQN3xcuzeAAQ221khaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SKgNK+XyPhNtnI0XAKINLSXON4dyFQhDlXCo90KgeTU=;
 b=geo8GV2omeuZg9p5O3KOqMJBFCDr+38uCS43/YwYhM9UZ+zMLSwJ6vQNoocelFa+AhZpz8XZbUxicDI/wS2NU/eBuS81nYkaq/U+rmp54JX/DTKh7aF5XQVxQycS+vWshw13JNiqFW2teKCidXiXo9xMJiT1eGaIdyQMcUME49c=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by CO1PR21MB1315.namprd21.prod.outlook.com (2603:10b6:303:152::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.5; Mon, 19 Jun
 2023 17:41:20 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::7d5d:3139:cf68:64b]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::7d5d:3139:cf68:64b%3]) with mapi id 15.20.6544.002; Mon, 19 Jun 2023
 17:41:20 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH 1/1] clocksource: hyper-v: Rework clocksource and sched
 clock setup
Thread-Topic: [PATCH 1/1] clocksource: hyper-v: Rework clocksource and sched
 clock setup
Thread-Index: AQHZmunMRY0uWgs/g0+c1NT6w1jjM6+SXPaAgAAFcRCAAAZKAIAACuQA
Date:   Mon, 19 Jun 2023 17:41:20 +0000
Message-ID: <BYAPR21MB168877B777F93FB6A2453B7DD75FA@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1686325621-16382-1-git-send-email-mikelley@microsoft.com>
 <fdc643c4-6298-d337-1d8d-3f28f6c1acfc@linaro.org>
 <BYAPR21MB1688E1163BB36DF03CC8E00BD75FA@BYAPR21MB1688.namprd21.prod.outlook.com>
 <07c5efe5-4eb0-121f-7b50-8f3fba68beab@linaro.org>
In-Reply-To: <07c5efe5-4eb0-121f-7b50-8f3fba68beab@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d34586cd-8829-43de-855b-774e18b889c0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-06-19T17:37:23Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|CO1PR21MB1315:EE_
x-ms-office365-filtering-correlation-id: 0b73e992-0d10-4f54-6cf6-08db70ec6462
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OcblweH2uXAhOQkEktnUQ8G8/+730gOlLkjQq9xWdZClTOPHWrWt7CXhqjcPZMvQTA8imqBrRP8QEH2tQFS/psWZMqLnmuu6V1bAnaNJFXjaXPjGIbP7IJ5t+iAORr+s9c0wuqDTvO736GJ8w/tIPmZwJ8xiPDeAqg5a2W7hbxBLTPw1p54OydaDClOjqxMldKLXILrG03xRWCnF6ZgJGfLsoDO+LmcqCCItZHix36vRfHFlkQPDca4VirP/fqkUHt1/f2Kmu7uA1EDl1SGYOMktzxXehKa73tBIFNGbz+zQ59XFb1ONNyWNRnaZvy38s/EO4lnRds/GHZ1kMhs682TTyBzG/b+Ws5+Gm877BeCkO05KVOy6SuunUpyHBRYnUFr3Ndc41rE5dXe+o+LkY3R5/Ykzz2s8pquaFmqvkE1WuOzgay5vp08R4IFzuAIai5NKSOYxNcwGQHuie0U2p1oHV5yNzHEjzNxPfUYQmmQR4bFb0gKb+f7wh8iRAUcT7XTRfQ54F9Ea4KjwpkGBa2rY6cI6eHTNElZfcL9EhEYVIRebyekDjL0RyHzWTP59TEarQxPfOIMa40SpKv/VSabqZAmjFjzH3mCyb41Tr3VE21M8/YR2l/rXMx/zuqrbLw9z6I6wYriMQVM0JyKuDYnkFu6mUt/xctnGTH/CYWVCFnoKYm1RBM71/VoMnrwO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(39860400002)(366004)(376002)(451199021)(52536014)(122000001)(82960400001)(82950400001)(83380400001)(38100700002)(33656002)(86362001)(38070700005)(41300700001)(8936002)(8676002)(5660300002)(66446008)(64756008)(66556008)(66476007)(66946007)(316002)(6506007)(53546011)(9686003)(26005)(966005)(55016003)(186003)(76116006)(478600001)(7696005)(110136005)(71200400001)(10290500003)(2906002)(8990500004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?V97kKTqaNV0uc7a1BHzdwFZR2SEFLkFu9/JpeSRHUAcgWDEdyB9K7Vi7WJ3h?=
 =?us-ascii?Q?XMZEvajjhcXI6+FV5wN2kyVg35Unm3fn3KR0v9JENyNetmnqd4quM+TD/qpq?=
 =?us-ascii?Q?uc4DPbX0OHd6P3rP9eXtsDWX+JaWrlQ0vMY06XQdDJscV8ot1i078R30fo7F?=
 =?us-ascii?Q?sFjhz1E5EdiPRZJ66Aoo+t4e/HpiMWs+lO7xEh5RzZju3grMqNG4yUMAi4Mx?=
 =?us-ascii?Q?yFCKjZYHoFmAuVzrKa+tlcQjb7yOXki+7tSWqISEwTH638Wqh0f8z/fQnrDH?=
 =?us-ascii?Q?cM06ZY+26pdqGb8056s53TADHIWwLmfKTFCyIAinejZejIp+yIXqg6ETyoE7?=
 =?us-ascii?Q?wzxEjBQE0+VzWr6IVsEPlx+/1uyZya8Nlo5s0I8/twvTK9phK0cDWTnPcg87?=
 =?us-ascii?Q?NzAnxQiumNKtW0/x4FUtd8JQ4Kv2Y0RQrqyW2Wm0xtGpjy5UP6zapR0LdF9k?=
 =?us-ascii?Q?DRaixgi35bQXFvoVJJ6kL1YqsvMp8kBTW38rULeyr6MGE4aqSHqhzmkSoEXe?=
 =?us-ascii?Q?OhKU+z8yV5JERuHL6yYDWWWCM/l+bRuIeLpS0RfmBtHajaQ5GLozdHErP0Vh?=
 =?us-ascii?Q?UVuxruJFM3CJwowNgNfQpcG2b7Js6w8KZD018GRReblWIt9sPKlRAae+F7AO?=
 =?us-ascii?Q?9LGHuG6HLfTUqUv0ZtxYnexCcywpfPzzv8pjXfjrZMtDGRKl4DSXd6wpKan1?=
 =?us-ascii?Q?qfIiA2SBRzUWcQfs5d7uudvXIyxMQifX3B9/Blwe0R5bDSRBokMOT3yO0LIf?=
 =?us-ascii?Q?GpvL098r/RBW7XfwDMOM6D5UMUntCN2waZ4zdndYoZR8RNowAD8QWqQxQwWU?=
 =?us-ascii?Q?p4dTA3VTnwLAvmI4v2LPK0JQCpw2okvLTFnCyt08YYaCk4+m+vYyS0LnP0zU?=
 =?us-ascii?Q?BHBbKWYeGtBJ30tY+eiN9fDHGf6effjkf5XfvHMRcd8fx4sKSdQsJtQDWyn9?=
 =?us-ascii?Q?HwqWX6cFJGO0HEwOOkgleWqi6Plxbviz/tkbobci+sSaG+GyFCO3elWqDOqG?=
 =?us-ascii?Q?KVMzHulKIIuCj3xlHMjpIdOMXRmqtlZNszGSOSZhx+vJIH8CljNWxYBcA7rI?=
 =?us-ascii?Q?tSv0lc/awyRDnC4oVzpsHz1ztbJEoB10G7pPNfgWFooJqvDKdocMKK8aaMwm?=
 =?us-ascii?Q?iYB5Ep6PImeO3We7k8w3WlBr+gAJeUHEZfcNN6hCQNTC5hai4U5oiBtXFk9s?=
 =?us-ascii?Q?cG3tOwPRIpctzeFUjE+ZywBzAVeLOIhWLOec+tDJjZoLyGzcRA0LjB4UiU9Q?=
 =?us-ascii?Q?0AJ1Ag6160/pqfw4GTqOE41OxKjPxG09z7D4E3dtO4yNNgajpBMKqfNAQv2J?=
 =?us-ascii?Q?LEMLHEvZNzlKlkTwnl8XHr/PFYd40LBPL5miqtrMDRcFJGJ2iqK+SK4jIhCC?=
 =?us-ascii?Q?duFBW0PCKKVzIfDJBChCcN/82zkcq0srCOYyDijDzRWuM852molWw1/m2TH6?=
 =?us-ascii?Q?La99mq3qJI3fhRkVKHTm3O+saArB8li8cJ9uoPib9i6CAgkMkPob5LvdpsvQ?=
 =?us-ascii?Q?UaSENDSUZLdoFzjxhw4x9IVZ/qdIO+nbQaop22HHhOnlBiyRcaI5TluTvLfo?=
 =?us-ascii?Q?YDaPHz7ZmYDhkZbWIg0iwYrp+OeG59hhGbc3QG/Sdj6cg1Y0z9aM4LCGnkhw?=
 =?us-ascii?Q?Xg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b73e992-0d10-4f54-6cf6-08db70ec6462
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2023 17:41:20.1627
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LLJDjaG+EOVZqT9xOKOZJBZbIQwI+5q5pMd4jo9EWBRHmD9I5AaPUYU0QTDFkWGJuUs3amYE0PeIBv+LNO9+3jzXKZRyRAWV2e9bBeoAelk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR21MB1315
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Daniel Lezcano <daniel.lezcano@linaro.org> Sent: Monday, June 19, 202=
3 9:58 AM
>=20
> On 19/06/2023 18:44, Michael Kelley (LINUX) wrote:
> > From: Daniel Lezcano <daniel.lezcano@linaro.org> Sent: Monday, June 19,=
 2023 9:16 AM
> >>
> >> On 09/06/2023 17:47, Michael Kelley wrote:
> >>> Current code assigns either the Hyper-V TSC page or MSR-based ref cou=
nter
> >>> as the sched clock. This may be sub-optimal in two cases. First, if t=
here
> >>> is hardware support to ensure consistent TSC frequency across live
> >>> migrations and Hyper-V is using that support, the raw TSC is a faster
> >>> source of time than the Hyper-V TSC page.  Second, the MSR-based ref
> >>> counter is relatively slow because reads require a trap to the hyperv=
isor.
> >>> As such, it should never be used as the sched clock. The native sched
> >>> clock based on the raw TSC or jiffies is much better.
> >>>
> >>> Rework the sched clock setup so it is set to the TSC page only if
> >>> Hyper-V indicates that the TSC may have inconsistent frequency across
> >>> live migrations. Also, remove the code that sets the sched clock to
> >>> the MSR-based ref counter. In the cases where it is not set, the sche=
d
> >>> clock will then be the native sched clock.
> >>>
> >>> As part of the rework, always enable both the TSC page clocksource an=
d
> >>> the MSR-based ref counter clocksource. Set the ratings so the TSC pag=
e
> >>> clocksource is preferred. While the MSR-based ref counter clocksource
> >>> is unlikely to ever be the default, having it available for manual
> >>> selection is convenient for development purposes.
> >>>
> >>> Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> >>
> >> The patch does not apply, does it depend on another patch?
> >
> > It should apply to linux-next.  It depends on two previous patches from
> > Peter Zijlstra in the sched/core branch of tip.  See:
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=
=3Dsched/core&id=3D9397fa2ea3e7634f61da1ab76b9eb88ba04dfdfc
> >
> > and
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=
=3Dsched/core&id=3De39acc37db34f6688e2c16e958fb1d662c422c81
>
> Yeah, but the branch is tip/timers/core
>=20
> Could you respin against it ?
>=20

Ah, OK.  Just to confirm, you are saying that this patch would go through t=
he
tip/timers/core branch, which does *not* have Peter's patches.  Resolving t=
he
merge conflict will be done within the tip branches.

Yes, I'll respin for tip/timers/core.

Michael
