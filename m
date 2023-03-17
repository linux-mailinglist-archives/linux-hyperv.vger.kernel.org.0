Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB776BEEBE
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Mar 2023 17:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjCQQqc (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 17 Mar 2023 12:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjCQQqa (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 17 Mar 2023 12:46:30 -0400
Received: from DM5PR00CU002-vft-obe.outbound.protection.outlook.com (mail-centralusazon11021025.outbound.protection.outlook.com [52.101.62.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B8773391;
        Fri, 17 Mar 2023 09:46:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GUZ684CnVPI1BUXM6bEJVLqoMwZhsaIhYIXeTRzMoCpJ9rc1sxhln4//miyJbqZk0M5yKJYbuGJuUvKmJHEnWhJ7I2kLOl8hIWQbFsq6oG2Lb0bSurcEx4FlDlSCwF6tt6k56UHOc0zEQIRXojFVv7CUllxjNrKLrMTHTJKZyed/DeSs7Hd0xgKNZDCRc9Wg41i371PUXzLUx+Q70dKDvMi6Ye1vB9MNpzA5ZJhWFtbG7Bte98Hb6TakLe6g+uez3Gzg2ZpZGbxzBdRuOWS7gNBxDqn1vv9Q9SXf2vMTb/z9H7itHfor4UyI/fUJa7/BQlNkBxS+/HWEO8fKSJ+PKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=brr6Bxnrp/rKzuNvEYRIjeqhiccYA9485UmvhD8ohRo=;
 b=J93LCewcQAsD6io2HHle1FNtudkjPyKXiTh643o5SkFQJKZid4I/etguryICYZEVp5X6+j7Gh0K6EzZgMajegbGBUIOEOrFE5arF+dA1PtiNWZrNjfeZZ/3dheELeGo2bs5wpJg0zr89GOX03/dGwPXRtW+GOwU+iTix+r02AzQor5p+sjtyRWbFvQ3KN/+Wbzsk9TeZy7t63OnlOEAveMCtbqL9sWedGiousCY/7fTDKjQ9iWmlZ5dxsg0VLQ/Hh59esgG+H0242pP7f5KOv2VJMoyoSzREFnz8er0PDGWbSmREEbS2AKfSeZ8zaG3SK49XJ/1IXPXIiWliN+yC9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=brr6Bxnrp/rKzuNvEYRIjeqhiccYA9485UmvhD8ohRo=;
 b=NgwbLRJ8Hwsp7/dw9gTVB4Z7tTiMtrXF+1g3PDqgayQoFtR7e7y4QcnxSbsaJ7lIMSESaGOopOr6O+T3sN8jphAWvaZ0J0K9e5dsQ9N5mPb98ZmbBECb8rSpaJ3NYle7iRuJiXPyTkCo8j5TXEqS9PrV+qcz9g7B3FqWeCiPQ3U=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by PH0PR21MB1879.namprd21.prod.outlook.com (2603:10b6:510:13::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.5; Fri, 17 Mar
 2023 16:46:11 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::629a:b75a:482e:2d4a]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::629a:b75a:482e:2d4a%6]) with mapi id 15.20.6222.008; Fri, 17 Mar 2023
 16:46:11 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "kernel-dev@igalia.com" <kernel-dev@igalia.com>,
        "kernel@gpiccoli.net" <kernel@gpiccoli.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Subject: RE: [PATCH v3] x86/hyperv: Mark hv_ghcb_terminate() as noreturn
Thread-Topic: [PATCH v3] x86/hyperv: Mark hv_ghcb_terminate() as noreturn
Thread-Index: AQHZWOpj38QitTc2cUa3ycvKpYsc367/LdKA
Date:   Fri, 17 Mar 2023 16:46:11 +0000
Message-ID: <BYAPR21MB1688F17B2E1C6043BD50BA31D7BD9@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <20230310154452.1169204-1-gpiccoli@igalia.com>
 <20230317160546.1497477-1-gpiccoli@igalia.com>
In-Reply-To: <20230317160546.1497477-1-gpiccoli@igalia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8bc43685-e1b0-47dc-a56a-2e1b585715d4;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-03-17T16:45:05Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|PH0PR21MB1879:EE_
x-ms-office365-filtering-correlation-id: fc07d298-e14a-45b5-0459-08db27071d81
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mwCrK9sgXC+zjTM3h+6m+DsDwy7KfdPFdW4tlHclAtbMQs19BK+iZWwm6exXmN+pO20VIS4KRrUwrwWD06C4XUuzHZcaW0mPqCvvvE+d0e8iqT8HJ9dD/+5CLKx6oSUIgGSJm/NCrlWwUB1XouJd7Vx0VUdJP+CPZRJ7D1CevZgaAOvIorIyn74t4D6CJwhtM4As9KaReP0nQRWfo/aaCHOcOQRYrGTFqcmbcPFZyneEvbA9msPPoF0fVsiJlzCKWH+KHTJr3e8BoW4w+QJ4OcPVU5qFgl4UTkeGTyZ4j2PZRraiir5CQ3NvU0PlzkgBoCA3wku687VGn0HfL6+p2e1HDEdG9XiFh2ugS6wxxAx3Rf1rTz/gbBuDI7jhaib8C1oVJeDsrlZkniGmSgZUrL38j2sSNdh8HonqBc06+sJU7foXFk0DYzVpabqvv1v3ZiDzVyf210CdArXQ2gp5ODkkIXTr6X2nXvDvzO9qK3+mFNsEZvsN4DV9zA21Ai1Td9cq7LY1W2L+yDcCM+iiKriyQYd+GhY/3nQpNR1njbGYD/vLLtYqzs944dzlF08bO5tLY0H2IlXhITZ7YWPQ8qPk2yqmm6Ebpm7E4mtMU6CQTzEGk3EqbfPYR+Ds7QBVLn8iXejKT8T7xgx/lffkahXy9D/V6PeFSsSQf1jCKyiDFTpbksc0BLKFiVhBc/zSsxHhnLStZlmdWQsloDe/X89Kax8Zs1Y7I1rBeFmbOlA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(366004)(346002)(376002)(136003)(451199018)(10290500003)(8936002)(7416002)(8990500004)(38100700002)(5660300002)(71200400001)(7696005)(55016003)(966005)(86362001)(82960400001)(2906002)(186003)(82950400001)(26005)(38070700005)(76116006)(64756008)(66556008)(4326008)(66946007)(8676002)(33656002)(122000001)(66476007)(52536014)(54906003)(9686003)(83380400001)(6506007)(478600001)(41300700001)(110136005)(66446008)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xP5eESxOv0wvO/qzK5zVHiaJPiY9vakqeHBBxWyfYOMuVSlL9XsHLE4QkM87?=
 =?us-ascii?Q?hgbswTQSK8HxOJWUj7PYqcO/r3qt8O+2eXvP3Gb2NsGGebcNUCGWXZJhvhbi?=
 =?us-ascii?Q?pWCFbbLLpAACnLJNaBZsSUVU7SnIqVCv8sf2rxg2CFTdmEVhRqHLxpjh1h/v?=
 =?us-ascii?Q?UIGfZo6qpd4BYc+LJCbmtNpwakFSWnb7bZaQWOGAmgV0ImSTwNKpxBudGMJZ?=
 =?us-ascii?Q?Xrlmp6pIcT7jIrNVuVLK7vHVPiAmm6iOSvfQaC/zodBQK6sZtzEwborxmPPY?=
 =?us-ascii?Q?Oe0uyNEAPEVnHZvSDfjzADDanmVRepSEUU6W4k53RCrMRFvWmxNQjhW/tFCW?=
 =?us-ascii?Q?iAK/hzZ1DWv/mQlXn9zFVNvMGev1L+3b0lQ+pubZfN/SoQiL5kQtPcF2PuLe?=
 =?us-ascii?Q?woj0Kq64Bzzi/GVB40cDOlfyfXebSz/IzH+7tG209h9vPaXhwWmpjqdkcXi5?=
 =?us-ascii?Q?YSVyw5dC4HQAQXyPgaj0EWmAT4HEa32SSyZh+VGdvywIgAa12RndM7O30Ewl?=
 =?us-ascii?Q?DM3ndEV1hH1T1G433yk/pxP7dycT/0wUG7cn2uPUQcpvvBwoid/0ITiA5DhC?=
 =?us-ascii?Q?VqpBwt3tMMdV74y6zh9NcLDVY/zXnBDDgdFXNwmBmNqLb8rjVCEtCYB8nL63?=
 =?us-ascii?Q?HfiJClOQ7zUXlyNRDEBb/FbS62pyGsH91i8PoT+smozPbJWslnt9DLrasY4y?=
 =?us-ascii?Q?fdQSxSbySfboqgTG5wx8HzWJ8Qb/pyM6DfL2mhQ6700OcAE2L/Jqyf8fF56z?=
 =?us-ascii?Q?WNx+fJKYeJfiujilMS0rylzOAXmhSmWcaQ6srOcxZJoXKIi1Q8zlyX8HUdcn?=
 =?us-ascii?Q?Q7N4PaOaWpIFI+fahoN4iDnt9jUYB5x1pkCmLictEOtmn2O2WKTNJRKv68jp?=
 =?us-ascii?Q?SXYp+XiwIkPvONmNBZr9CZaRRpr00RCpn5hJ211QGyiV08zOe9N5vFt72fx+?=
 =?us-ascii?Q?1VT1y774RVLs4XibAvMYNwzAkpluwgiNxOJvqmpiOGGPsV6aj/NHHB37QaDm?=
 =?us-ascii?Q?T+dvTOMYmBAzXqx6Mwdfb5m2nu2i5Od6zSwUzMcir+8q95776kN8N7k8qqEK?=
 =?us-ascii?Q?eA8ByRCnZ/TtTbLVNcU3wkA1n/b2tVCT87spsgKyHeZODjkEFjI/TOzvElLJ?=
 =?us-ascii?Q?m3XgAjr4D3S7nHcufNVggoO37pB4LBfhAA6Fmx2xHQMzCFKQ9ZkoHyk8N8a+?=
 =?us-ascii?Q?/eEjm9LAKbrMV64wtl+kdRi7eYdWKRHDLEUmyjo1NznxBX7lIsGYkcWWOSLg?=
 =?us-ascii?Q?NAFhtC7pIR2GRC+N4eOg7ZWp8dGrEs2zWwmHV59UyD/OhFXrh/kFBM2g9+JS?=
 =?us-ascii?Q?DhY25D2nNuTaKE8Yoh1LW1bcxVxuJsUxTvTwUYMsoeNPK1EY4N44B/O2wboE?=
 =?us-ascii?Q?Lwpal8wScofje1X+MS7N8ThNufwWu9uSLeIpz8mx4YMh+bWRHzSR1EKqaWct?=
 =?us-ascii?Q?dhyv6sEf+mbTQWvbbaB9r4AsjUmyL3iw24r3+tka8mrHa/IREvUNO2j0ol50?=
 =?us-ascii?Q?Hfkde1pWF+RWF7/pQqfVIkiDQLKvCPX+QZsxBFxUvFOWnHYhoUPmG3m05XMT?=
 =?us-ascii?Q?9H9f47DV3MwI60Yq0tT7Sqsf52sOSxX6hAJBjeo7MGbL/k/Fq6WhRdvrs3W4?=
 =?us-ascii?Q?Zg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc07d298-e14a-45b5-0459-08db27071d81
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2023 16:46:11.6044
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wf2yguC7yxei6v0/9vl7aOpOeQHJfgHHz5rpLIpZ1llSolm/CsWwZ11dDFJmHEcWRRDgjjV4AWMlt7EDYkbUOKrAdDC/6kUPfPr8LvdKrGY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR21MB1879
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Guilherme G. Piccoli <gpiccoli@igalia.com> Sent: Friday, March 17, 20=
23 9:06 AM
>=20
> Annotate the function prototype and definition as noreturn to prevent
> objtool warnings like:
>=20
> vmlinux.o: warning: objtool: hyperv_init+0x55c: unreachable instruction
>=20
> Also, as per Josh's suggestion, add it to the global_noreturns list.
> As a comparison, an objdump output without the annotation:
>=20
> [...]
> 1b63:  mov    $0x1,%esi
> 1b68:  xor    %edi,%edi
> 1b6a:  callq  ffffffff8102f680 <hv_ghcb_terminate>
> 1b6f:  jmpq   ffffffff82f217ec <hyperv_init+0x9c> # unreachable
> 1b74:  cmpq   $0xffffffffffffffff,-0x702a24(%rip)
> [...]
>=20
> Now, after adding the __noreturn to the function prototype:
>=20
> [...]
> 17df:  callq  ffffffff8102f6d0 <hv_ghcb_negotiate_protocol>
> 17e4:  test   %al,%al
> 17e6:  je     ffffffff82f21bb9 <hyperv_init+0x469>
> [...]  <many insns>
> 1bb9:  mov    $0x1,%esi
> 1bbe:  xor    %edi,%edi
> 1bc0:  callq  ffffffff8102f680 <hv_ghcb_terminate>
> 1bc5:  nopw   %cs:0x0(%rax,%rax,1) # end of function
>=20
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Link: https://lore.kernel.org/all/9698eff1-9680-4f0a-94de-590eaa923e94@ap=
p.fastmail.com/
> Cc: Josh Poimboeuf <jpoimboe@kernel.org>
> Cc: Michael Kelley <mikelley@microsoft.com>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
> ---
>=20
>=20
> V3:
> - As per Michael / Josh advice (thanks!), added __noreturn to the
> function definition as well.
>=20
> V2:
> - Per Josh's suggestion (thanks!), added the function name to the
> objtool global table.
>=20
> Thanks in advance for reviews/comments!
> Cheers,
>=20
> Guilherme
>=20
>=20
>  arch/x86/hyperv/ivm.c           | 2 +-
>  arch/x86/include/asm/mshyperv.h | 2 +-
>  tools/objtool/check.c           | 1 +
>  3 files changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
> index 1dbcbd9da74d..4f79dc76042d 100644
> --- a/arch/x86/hyperv/ivm.c
> +++ b/arch/x86/hyperv/ivm.c
> @@ -127,7 +127,7 @@ static enum es_result hv_ghcb_hv_call(struct ghcb *gh=
cb, u64
> exit_code,
>  		return ES_OK;
>  }
>=20
> -void hv_ghcb_terminate(unsigned int set, unsigned int reason)
> +void __noreturn hv_ghcb_terminate(unsigned int set, unsigned int reason)
>  {
>  	u64 val =3D GHCB_MSR_TERM_REQ;
>=20
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyp=
erv.h
> index 4c4c0ec3b62e..09c26e658bcc 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -212,7 +212,7 @@ int hv_set_mem_host_visibility(unsigned long addr, in=
t
> numpages, bool visible);
>  void hv_ghcb_msr_write(u64 msr, u64 value);
>  void hv_ghcb_msr_read(u64 msr, u64 *value);
>  bool hv_ghcb_negotiate_protocol(void);
> -void hv_ghcb_terminate(unsigned int set, unsigned int reason);
> +void __noreturn hv_ghcb_terminate(unsigned int set, unsigned int reason)=
;
>  #else
>  static inline void hv_ghcb_msr_write(u64 msr, u64 value) {}
>  static inline void hv_ghcb_msr_read(u64 msr, u64 *value) {}
> diff --git a/tools/objtool/check.c b/tools/objtool/check.c
> index f937be1afe65..4b5e03f61f1f 100644
> --- a/tools/objtool/check.c
> +++ b/tools/objtool/check.c
> @@ -209,6 +209,7 @@ static bool __dead_end_function(struct objtool_file *=
file, struct
> symbol *func,
>  		"do_task_dead",
>  		"ex_handler_msr_mce",
>  		"fortify_panic",
> +		"hv_ghcb_terminate",
>  		"kthread_complete_and_exit",
>  		"kthread_exit",
>  		"kunit_try_catch_throw",
> --
> 2.39.2

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

