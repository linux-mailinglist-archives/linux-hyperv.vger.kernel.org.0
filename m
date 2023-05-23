Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1562870E4B2
	for <lists+linux-hyperv@lfdr.de>; Tue, 23 May 2023 20:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237539AbjEWSaf (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 23 May 2023 14:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234534AbjEWSae (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 23 May 2023 14:30:34 -0400
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021025.outbound.protection.outlook.com [52.101.57.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1CBE5;
        Tue, 23 May 2023 11:30:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VjZCkvaoDTq+UY1Tx+LrTtkHA979TykAjbXJxjG2B/23DLKkKqgwMGjd5eTDx2J/4l28/jk2hGkUMVPsjLjkSDDOl85TDBx+qrh9HhW1pzUrHdbHzc9ngcf95xxc1IFV0AJY/5LZISA/hwhH4pwEErf7cJy9krkOmZOZaqTyLhkEjVQ9bMuUQsEuSGmrdTDpNw0zt9LzPY5M/nD2Al2P/oNY8JLEn11FCUVOZ0jlNGyT3LtvvjV7SH/QMbcWaixjQQhEv8R5ATsgFkL6O1LuMxW84Dsj1NTAEjXhPxhyNqikpX0uHAPE8hz4DVOiLBVob6/tTgzNiWLS4fHbm0tXcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MRIaoaz73rRkEhltJVIVTuh4IeD/M80n4Run0TugJ0g=;
 b=hCnEnfI2GPsoq09HzL3odqa0cxkEzSbq6UmovjkFHFAwiaTXaPlZNoFAtdiEGzVEqEUFUW5LSzqjVdkIJD6skP4EwOg9DAvpFV8B7R8jDNWIuoLdFOG0tSb5gqAxvGi3QGOxLZaMYZFFuM8cnxlaecr/vmey/WTInRS372oadB4S7fdm4TF1o8shfCE/OX33dDJpoZuBGBrm+VOTat2mlKO3Vw0609CCl3u2/VTzGLDKF9nydvFtgYDKckVw2Ky3oxOyVLkSegr7Fa8AS2aWqqcxiNxduxIPaExFRQKGqbnKqIP7F+/lmkmyS1uq8lEwz5J9CrDgKOlUooOOdtXf9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MRIaoaz73rRkEhltJVIVTuh4IeD/M80n4Run0TugJ0g=;
 b=J43VU34KqUjWV8Oo+HCes/BcUVSeisrhTqul0bUstVSeNfPLV5lLZ34EQfgukkuS+8+Jvx1QYXqGCNDY2H0zbbDLhRyIj0xzIQWkaVNOw8uHzbB+En3A3dnnozZaBECmLfxFm+yosmNL9ymqOVzvH3ct+67VXutvfVsPVD6i1mo=
Received: from SA1PR21MB1335.namprd21.prod.outlook.com (2603:10b6:806:1f2::11)
 by DS7PR21MB3575.namprd21.prod.outlook.com (2603:10b6:8:90::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.12; Tue, 23 May 2023 18:30:29 +0000
Received: from SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::c454:256a:ce51:e983]) by SA1PR21MB1335.namprd21.prod.outlook.com
 ([fe80::c454:256a:ce51:e983%4]) with mapi id 15.20.6455.004; Tue, 23 May 2023
 18:30:29 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH v2 1/2] x86/hyperv: Fix hyperv_pcpu_input_arg handling
 when CPUs go online/offline
Thread-Topic: [PATCH v2 1/2] x86/hyperv: Fix hyperv_pcpu_input_arg handling
 when CPUs go online/offline
Thread-Index: AQHZjZobH9Pry/rM70OIGsPwJiaqdq9oLc1w
Date:   Tue, 23 May 2023 18:30:29 +0000
Message-ID: <SA1PR21MB133568FEF69C1F3F177B6E32BF40A@SA1PR21MB1335.namprd21.prod.outlook.com>
References: <1684862062-51576-1-git-send-email-mikelley@microsoft.com>
In-Reply-To: <1684862062-51576-1-git-send-email-mikelley@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8b7074ee-3a49-4d84-b03e-1fc53ae2d106;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-05-23T18:29:25Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1335:EE_|DS7PR21MB3575:EE_
x-ms-office365-filtering-correlation-id: 39eeffbd-1752-435d-c8d3-08db5bbbc927
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BpYYNmkYRyO4MYrk0ofJFykD5uzK7ovnd/uzHPPVh1iWrTJH/3MozGzyfRRgiyzQKOaRPwiTEjyd6uhMP+0pulPTiNVcUXzC7CUjICNeRqhjZp5lAeKm8LaDCLJlOUcJz1h3WZ16JTvg3GBPZVD5uPLQgJefj/c1QW6WDycTjpk9cPWZSDhoaXek4afGHaEi7+SwfVAj12UddVgY0/1j+skv/iJeoHKV9lRxy9w3qyjCi3K6K+IcKBK76ubNMM65k6I4PXOJzw4nwWRCu3uJ9jphE5ocxqyji1jShpWPgKKmJg05Bm+kg8ZKvawmiYVWgKGmBG1RcUr+FG2L98YdQwxjN6uBdCS/5VHVQ7owQvCpO/KwwjMByO+34QmFTDQaXdqndT9FeYc/gQSHZR/rkpyRv1/Et7Ai66yHYy4yhsR7g1VgAeCHPNGWrQwjPgL61GW30mTIt21+CRwFBZG2DwBjSrdCc+OjmF2iHTWrdU6yhoI+tHayo/zFY9RFX8nHGA/3Caj8Sdm7WV44Is1OCaQiAtTStvf1EVNliVKyoNfHLQxJ1G1+TNY9/QsIiwFHpyBJ3dWoZ56RbU3z24GqaKPpdkp8zdc5kmBRV0yHUp/FkBHTmYJigvtraTwUqM6kPQcRT8dxp2nDBdPkvClRacSRM4ojnLR+nZOYiSXdpFZrq56bu0zsFVjaJW4jN+QD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1335.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(366004)(376002)(39860400002)(346002)(451199021)(8990500004)(66946007)(2906002)(76116006)(66556008)(5660300002)(83380400001)(7416002)(52536014)(8676002)(8936002)(33656002)(786003)(316002)(110136005)(66446008)(41300700001)(64756008)(10290500003)(71200400001)(55016003)(478600001)(7696005)(66476007)(26005)(186003)(86362001)(82950400001)(82960400001)(921005)(53546011)(9686003)(6506007)(38070700005)(122000001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yh5G+U3VP9HvKAzgQIEMvM9KEYgN6OZjh+Ii9FnTnHOATwx5zXd99tn25jGU?=
 =?us-ascii?Q?8xhlkg9lAnnQpiFX2MfcdwW3BoCGY/7dl8dnt81BrOmtfSHMEGmEF9dRU0iG?=
 =?us-ascii?Q?9CLgNVeZ47v7UtC7MmdvBu7p6jujeJ9FzQOfThC5HQsoO8e8YCQIXAFktIoD?=
 =?us-ascii?Q?YKKxQmA+5JoP4GBfOZaD9WoebouHeVTCD0bpMOrb2z26H5glfgWV07EzTI8v?=
 =?us-ascii?Q?JtMVpGwcAadRvGoUz+jr0/yDcv2qqKWMey8+yyjDg4J0adPjEzPuVYf1P5RB?=
 =?us-ascii?Q?FRXeq8LiHEuOfIkjjAfaekz7WCIwtEOySZ2hEL6iJd4YTdHC8snAKEt2saYn?=
 =?us-ascii?Q?vNFOabys1d6GI/cFOTGgHdQapWYDJkr18aNFpuQEzOyPOeZU8t4HhmcU6Cwa?=
 =?us-ascii?Q?2jg1Qwu1EaF2Yjk+X8T+Af97dA61OVXpV2n001otSWFCF0QXuzQSGH5ujlZt?=
 =?us-ascii?Q?P2v7Fhsmds38BLUJ0r0B0OBziG8+vUT9UGhS6KVVoTMRmtOl3jlTqqjvK4tD?=
 =?us-ascii?Q?oHDm/US1iYa/x14/fet+gD9odB1KlMi47uOGH6yv/sbm5+tSxh9Jd4zSj7O0?=
 =?us-ascii?Q?fdx7h+rjVPdMRhNg/Lr9MscGua3To5+7qTZ2nWWrCUojyJHFKYdDBGD+/2e3?=
 =?us-ascii?Q?UiLXP1MjUzrlEv+ocMJ1hrwvFXV5sPLtHj2gLcsxBKUksOvoHu0MqBw5bsRm?=
 =?us-ascii?Q?g3z/Q/OHsF5jvw7Sp/lBgGckProYcJTswMoIKNwZd+W/Tto2UrVBaKhUFszq?=
 =?us-ascii?Q?XZzOdtBLHpNV8v4GJ1S3WspI6yn/itcInEk/1xryObU4Zhne2qn/1uF28Yes?=
 =?us-ascii?Q?Ylj9G7oNJFY8L/3TZEnvxUIYDV9alY1Do+tTtC/kEJQOIoyBCRO2Pz8D18lP?=
 =?us-ascii?Q?bpao/FfoJXLolIZNQuDVCXABKDltVB/mlKsieTGi11P56ZX7J7qSYpb3gJMW?=
 =?us-ascii?Q?v0y4tRvzt/1+jonC4CVucDfJiB5IcOaVp/CswhdOQSBrB3uODj/cuyDA0OvM?=
 =?us-ascii?Q?xXz5dK4DLp7kWopWVCqDj/6oDLqGvWNJ0CynadJ53ZCFtyfv1QuRz8wLHnUj?=
 =?us-ascii?Q?cSw4zIzpk3ZFAUHFPFkkrl4h2OYKf2a6RascIpyF14zIRBHlP6OhIssvWQFe?=
 =?us-ascii?Q?JrmkC15FGLp0m6VInOb6XErHK3DEa0fnzFcwf9g/KhJkKEVW5OBPIPeOQb8W?=
 =?us-ascii?Q?DxEfJpY2Pv4Ec7RVMjM1Lu1KnonU1aEyLtacjVMjkebW4vCrHJzYvzHDz2yQ?=
 =?us-ascii?Q?QSacQswqilC+l+YUQWFum5ik7uxJdPdTMizBw4RGaReR3y/jXBTeOFluGDhG?=
 =?us-ascii?Q?rZFczDGKS8BryFJ8WSlcY2qMSuZHDc1wpZcU82I0NTQ3NZFbXxS0n2zV7WD3?=
 =?us-ascii?Q?Ul2H0W5B/LTlH+MQYgQndvj1v35m4SNMJdan9/o3sZyRZmmgwKGKEt7WYKV7?=
 =?us-ascii?Q?6GvRaP4pkMRK0SNr1YgnmsxvfCQ9WAhWTXNV5yTrWdg9fXj3MC0ezDYzRr7v?=
 =?us-ascii?Q?X1fVfgE+hKl8lrxSXvYmg1aM1ATvRTkyGxCK3nwBEOuKPTwySxd4piyH5i9P?=
 =?us-ascii?Q?3+I+pq1/wtXnoCfnN8vCsxiAER7aOHT/Tc5jGYnZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1335.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39eeffbd-1752-435d-c8d3-08db5bbbc927
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2023 18:30:29.4315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P3n3EDad9JTfkavU5JmDg2EO2/RnWC21jqmgsbqwqdnuPBlC1pqF1AFwhaxWgqUWMNscM4M/aPI6RpY6+GXE/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR21MB3575
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Michael Kelley (LINUX) <mikelley@microsoft.com>
> Sent: Tuesday, May 23, 2023 10:14 AM
> To: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; wei.liu@kernel.org; Dexuan Cui
> <decui@microsoft.com>; catalin.marinas@arm.com; will@kernel.org;
> tglx@linutronix.de; mingo@redhat.com; bp@alien8.de;
> dave.hansen@linux.intel.com; hpa@zytor.com; linux-kernel@vger.kernel.org;
> linux-hyperv@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> x86@kernel.org
> Cc: Michael Kelley (LINUX) <mikelley@microsoft.com>
> Subject: [PATCH v2 1/2] x86/hyperv: Fix hyperv_pcpu_input_arg handling
> when CPUs go online/offline
>=20
> These commits
>=20
> a494aef23dfc ("PCI: hv: Replace retarget_msi_interrupt_params with
> hyperv_pcpu_input_arg")
> 2c6ba4216844 ("PCI: hv: Enable PCI pass-thru devices in Confidential VMs"=
)
>=20
> update the Hyper-V virtual PCI driver to use the hyperv_pcpu_input_arg
> because that memory will be correctly marked as decrypted or encrypted
> for all VM types (CoCo or normal). But problems ensue when CPUs in the
> VM go online or offline after virtual PCI devices have been configured.
>=20
> When a CPU is brought online, the hyperv_pcpu_input_arg for that CPU is
> initialized by hv_cpu_init() running under state CPUHP_AP_ONLINE_DYN.
> But this state occurs after state CPUHP_AP_IRQ_AFFINITY_ONLINE, which
> may call the virtual PCI driver and fault trying to use the as yet
> uninitialized hyperv_pcpu_input_arg. A similar problem occurs in a CoCo
> VM if the MMIO read and write hypercalls are used from state
> CPUHP_AP_IRQ_AFFINITY_ONLINE.
>=20
> When a CPU is taken offline, IRQs may be reassigned in state
> CPUHP_TEARDOWN_CPU. Again, the virtual PCI driver may fault trying to
> use the hyperv_pcpu_input_arg that has already been freed by a
> higher state.
>=20
> Fix the onlining problem by adding state CPUHP_AP_HYPERV_ONLINE
> immediately after CPUHP_AP_ONLINE_IDLE (similar to
> CPUHP_AP_KVM_ONLINE)
> and before CPUHP_AP_IRQ_AFFINITY_ONLINE. Use this new state for
> Hyper-V initialization so that hyperv_pcpu_input_arg is allocated
> early enough.
>=20
> Fix the offlining problem by not freeing hyperv_pcpu_input_arg when
> a CPU goes offline. Retain the allocated memory, and reuse it if
> the CPU comes back online later.
>=20
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> ---
>=20
> Changes in v2:
> * Put CPUHP_AP_HYPERV_ONLINE before CPUHP_AP_KVM_ONLINE [Vitaly
>   Kuznetsov]

Reviewed-by: Dexuan Cui <decui@microsoft.com>
