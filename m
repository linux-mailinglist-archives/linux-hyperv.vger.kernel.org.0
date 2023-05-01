Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56C586F34D7
	for <lists+linux-hyperv@lfdr.de>; Mon,  1 May 2023 19:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232557AbjEARFt (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 1 May 2023 13:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233550AbjEARFH (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 1 May 2023 13:05:07 -0400
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021016.outbound.protection.outlook.com [52.101.57.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA9A4EF8;
        Mon,  1 May 2023 09:58:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LZXLFbuN5Fsp4MuIvE6aPk8OuFpGVVgHZyNhct/Fkb6iksHwdfCuXCP+dX8kswqfG5zHqWTBxBWhhwrD4NqGKux86Pv7fKc2izqwjHAuOkxWaf0iUc36yvTuxeAj36SdHB+/nxF0o+3SEiNA8LRA9SxKe6d/iSbXZH1tGl11vrUpPB2FeRdAd4Yf2Lb694QK30C3yvpVs0/Zk2MC6uPeKYSrkYYaiU7zbmVCAsZZZTato+AmGBTPO+SZ1SUYtTH1v0v5MGMAn4MIYgEM1CzhWV4QDaFMtG3FFVoV/fPLB7/ZH4GVQ6QJiJXYjWybadonq400ayiWBJ8/A3u9SOIpbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j/+jyv0mLqRd2TzuclSnhXcnq0o7yJCMgWcaaoWBXN0=;
 b=GsSjoIzfzm99vtKgkjvPk4idwUyYw3syT3iLwWdIODOh7BYhB9CEeoB8/IaVrKE+mbDKki/qYNkGM6HMqsV1APEsRmO/L0yPpUuUmyfGDpbbp+fJcoW4xvoWfWTSTUArc+ZhRQyuiAN9uRD8l7jh4Nk21zZ0OzGM9Lf4okGpfjfA2Z/0opWzoSMHG3APe/G9UfLNOBleSJfixy9qLkzgw95mpmaUmW8pZx+55JdLI/vBiX9XVNL2e8r0FPs7FJs13yk+CyuDXeNw9Msg9RVgGpoSwOS4bukvbzqsBNpmtnVooFtIC3KHeDNRI8GXCmVgmo3n+HfGfHxtqOSRNJKlbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/+jyv0mLqRd2TzuclSnhXcnq0o7yJCMgWcaaoWBXN0=;
 b=K4YfO0qbkwdZlu8UxWCbJcxHsOBN/8tB1Kgp8yTymYx0CL1hbmzvVB/Sep6cO1zy3EMNGAynL7+fQyUT8fnOavO8nz6wwxnLJG5BANGl/spPYXH9uMQJdAiT3oOLd+3WadSBHyfQq3U+qhGWZP/t/kaa+XzZVryLPgroCbdBU2k=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by SA3PR21MB3932.namprd21.prod.outlook.com (2603:10b6:806:2f0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.24; Mon, 1 May
 2023 16:57:57 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::89f5:e65e:6ca3:e5a7]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::89f5:e65e:6ca3:e5a7%6]) with mapi id 15.20.6363.018; Mon, 1 May 2023
 16:57:56 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Saurabh Sengar <ssengar@linux.microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH] x86/hyperv/vtl: Add noop for realmode pointers
Thread-Topic: [PATCH] x86/hyperv/vtl: Add noop for realmode pointers
Thread-Index: AQHZdpT9Z0UV1Ykq5UyxGk0VlUOcFK9FruAA
Date:   Mon, 1 May 2023 16:57:56 +0000
Message-ID: <BYAPR21MB168833D41D1214DE3892874CD76E9@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1682331016-22561-1-git-send-email-ssengar@linux.microsoft.com>
In-Reply-To: <1682331016-22561-1-git-send-email-ssengar@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8ee2fbc2-9802-421e-8837-b1390483d7e1;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-05-01T16:57:31Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|SA3PR21MB3932:EE_
x-ms-office365-filtering-correlation-id: d94a96c8-a8f6-41d1-1d53-08db4a65362f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mtUCCPLTwPWSheslKUYJZJbIFml5WYN/0xDMXz+eQMvCoSKzFcfobdV7DFt/HRK2uOp8hz0Xy6r6+hNxWs06yCD+Y+zvHpPRuNonD/fAKiI4WK5RDwNYlofDCPHMBrXpFYRLnchBLzG+hcHcER0AFLeCneQeV74RiUSH7DCFbrcAoQVInO+TyzR+HLMpDd43Z30u36+wMLuD9Az7Eb9iGC4zKN4S0MpPXmEk34i0ane6fFVEqCCShCph6NdySkPeh/MjTN2x2EQc7/c7QzA/fJIwcqGegMtYEarRnVAWjrlu1s4tGtTBe9NFNlf0izGccuV0eB8IIrRjuVbffBVAITeNTgTXyoPrpE86yJzvKO2+ez6+cGDIBu5SRZzvkRFH9H4omqb78oyTPLq0ehzJkOd3eYkUz/FR15e2MsGvasdnddFgB/+7Wl87afPq5GdK7ctsyBDzrhTHdgdZdXcajWMPojmvn4GT29c7RQ11QT7Rk1Y6zJNeX2DpvPyseat+m0514UUQQGm1m8vJFDZ9XjpKcDeXLy0I5ytvlh5n3VLCV9jSi4+RGIMqOg2ATQreTDUwKA+TQnizM77R17IpZb2UHTaN/2B9gfz48HDV2anAQw/xfvoTqn5qdweJA5q4gIC55FZbn24pqnATwwPWfUt6F1KxbJ1XQf0/u2ZcHFNRIx2k15sJeaem0QwIz1Yz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(366004)(39860400002)(376002)(451199021)(186003)(71200400001)(7696005)(55016003)(110136005)(26005)(6506007)(9686003)(64756008)(316002)(76116006)(66946007)(66556008)(10290500003)(478600001)(921005)(82950400001)(786003)(82960400001)(66476007)(66446008)(8676002)(8936002)(52536014)(5660300002)(38070700005)(2906002)(38100700002)(4744005)(41300700001)(122000001)(33656002)(8990500004)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2BJQSFaB3oPX3VczHpLUJvUGBorxQscfnl1OrMtOgNmtaykXPb6AlOFfzVIj?=
 =?us-ascii?Q?RXOrNQa8LGN0sxiQvTMZ0ihEyW0fmqgbCbnXxbIwSJw1f/6pr6PDfIhb/QXL?=
 =?us-ascii?Q?y7iqPHozaY+co1TSo/ACOvEcKWK3SIe4AJZpSXiVqXfAktzhEGS8ETJI/PHv?=
 =?us-ascii?Q?JL5YCEPvMPasQiDpFJdLHSBSO2Bbg5POmyg4e2n2w3GNuXQl7MZAY+1YB1eE?=
 =?us-ascii?Q?9YeRXjb46sP2GT4jr5PFIC0UB8Z+oikqkfqF7r919rNELvXq0nnq/+I4woKj?=
 =?us-ascii?Q?iO2WR1WcjmRI7+VjZfEHlBbyATRWl2QZYBYbLiCFjG/wStmAVD6fsqd++qJG?=
 =?us-ascii?Q?uxye0VdH9QxgUL8qBxz7EU6bCgFYEijNOc9TJHu+ZHjcKtyHuUq5FLXptBsV?=
 =?us-ascii?Q?KXSfrYgPeWpRFUEfr89pt/2odWh/21wyszmKZj0vs98QzwzisFO0r279qtTg?=
 =?us-ascii?Q?6NyLJCM7SGxNwkHNq8fBVb0OppuBF8kffHAv/QM/j5hMq1FbogfHiPpeqIuI?=
 =?us-ascii?Q?9HnI2uKw0Y8rd2mROok639w2B0+tfwXKlrMPQBnP9x5NEvgVWJubqY6T7Mxi?=
 =?us-ascii?Q?TyAqolV9Fk3haICB5z70iC2blns4wH06r667qCKGQ20EDGaBcM7gxHVnql0P?=
 =?us-ascii?Q?enBorNGDxadsIZdVAystEbnpEVPKRdYGW8kTxj0OCFCIVfQlBEhqV4pdKikR?=
 =?us-ascii?Q?wBbKc3Yc/Jc7z+zMtZ5wFVTG4WoVXMS6VkyWogn7Xkn4jxKrdWZtIHqydSPC?=
 =?us-ascii?Q?pvUgzBaFw0NGfyUpXItPXXIJr0Oe3EKxicuW9koQgPGO7Hyo74p2F9twPb2k?=
 =?us-ascii?Q?Fe4p4iUikmxsi2VLQEmV2oVJa1ZvyCXtGxODMixLOpwBYVehtvCM4IGjH+un?=
 =?us-ascii?Q?IhPnoRGMVWBmSTFJ2lYfPonLBQV2h6O+NQ05DISaZQxLjayCM4n4dC98m0cJ?=
 =?us-ascii?Q?pW+QG5wUXQdqBI9JT0SZ4xma9wuajmU4f0D/U7omVOrjNvcgxoHwl9T3OHxY?=
 =?us-ascii?Q?zLZ6KlR6p5BZGSQUQY8JsPss1ge5oMU1JGk9+qCilhC/RnEv67FQvnrXfREj?=
 =?us-ascii?Q?hxtRWEvjrKmVq75O9CTNH1I5OHDjpe/8M2rFgmmkNzaP8cB4U5xHm72UceEb?=
 =?us-ascii?Q?rDrnptlHQjdPRdEKix3zuWu3b6yjns2uE3wcYnRY7RSREi0cCdDbfqpezlNs?=
 =?us-ascii?Q?do3jzun8vttApExaljnkNBrNv0d189eWDZaoJmkvVUZ272UvdGBOUQUDDuxz?=
 =?us-ascii?Q?gXuPYpI34K4ifEaXY9mYs7GoSpFavDZLZfPBfE1CzqGLr3LOh0s2yWFi5Ph7?=
 =?us-ascii?Q?oXJS+Nefil5rySiJMiMzRkRq0B1kt49o+wxhDR7joghDHsX+zz/4zL/Wcb/b?=
 =?us-ascii?Q?2yU0t7+a7XARIfmbdIMtNt0CYDiQRTT7Lma7xUg9+ArGVui5HrWMdgzCe5Pr?=
 =?us-ascii?Q?5jnl99wnepMANsToPCgjauZ6fcGn19tmBx9XGoBUcCdhr/2xj+EAKOVVqcw1?=
 =?us-ascii?Q?cb7+z7AHdMaf+OYV64d4k3tS20A7MLmm4B/G1CM6eMtL7uKTMcRXaP+bKQ/k?=
 =?us-ascii?Q?5rkL6XwzabyMtUqdG37oHN78yOz8n4PZMCrSc9a7+gbWoQTMcqtLic7GL75F?=
 =?us-ascii?Q?+A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d94a96c8-a8f6-41d1-1d53-08db4a65362f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2023 16:57:56.4103
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eJR+Zy8VhOd9kMKMzhvSjdhwq2+QAl/JGagHVxxqUlvZ+m9teZFyaGFLS7nx+ymqHdYOCebeT5gFAuk3yPOj+ntwL0RctvkB9ilSULw59A8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR21MB3932
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Saurabh Sengar <ssengar@linux.microsoft.com> Sent: Monday, April 24, =
2023 3:10 AM
>=20
> Assign the realmode pointers to noop, instead of NULL to fix kernel panic=
.
>=20
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
>  arch/x86/hyperv/hv_vtl.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
> index 1ba5d3b99b16..85d38b9f3586 100644
> --- a/arch/x86/hyperv/hv_vtl.c
> +++ b/arch/x86/hyperv/hv_vtl.c
> @@ -20,6 +20,8 @@ void __init hv_vtl_init_platform(void)
>  {
>  	pr_info("Linux runs in Hyper-V Virtual Trust Level\n");
>=20
> +	x86_platform.realmode_reserve =3D x86_init_noop;
> +	x86_platform.realmode_init =3D x86_init_noop;
>  	x86_init.irqs.pre_vector_init =3D x86_init_noop;
>  	x86_init.timers.timer_init =3D x86_init_noop;
>=20
> --
> 2.34.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

