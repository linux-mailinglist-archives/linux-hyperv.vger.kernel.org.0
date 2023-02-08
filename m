Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4282468E535
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Feb 2023 02:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjBHBE1 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 7 Feb 2023 20:04:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjBHBE0 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 7 Feb 2023 20:04:26 -0500
Received: from BN3PR00CU001-vft-obe.outbound.protection.outlook.com (mail-eastus2azon11020019.outbound.protection.outlook.com [52.101.56.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123F6975F;
        Tue,  7 Feb 2023 17:04:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fvnbopikcMrT5e1Qr5SW68CxZMfQO/3cXcM6HRFXtXjwhanVPj9XKdyTJxDjioMCM4zIc+7dPyXnNLwX5KLYaImjncKl0YsBw6WHklJZWnNL3z+YQDNwKPZW5GVhD13RnsVoap/tN008XH3p7dtNWiUnr6MDrRsBgPiudbBPLpDYv0i7/eUNA36PwtMnzUsRQWbUohrW6wBVrWyTWJ9AMCSNLh/ByZPrSYBSSv+E04bwcqAESWStHPX/MbftZbHS71qWr9hgDMeNvSyT92wwG8nHut/7uhZou6kkt7aBz+e9FXCqUsVEMgb+Bb/NTAfKa+bTvX/67j1rtQ+U8eusRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NIg4Pu4Mtf0ljvFgY0Bsi80+0IT07AWnYeSlB91akHQ=;
 b=ekUzF9zzAYn3PXr2MpzkNp68jT5+gh7Wou8v7eeHwGhExEFsvAhZaChV0ON1Bn1nu7RDlsgJvRjMvYvyau52yuL3ib9cVONpSaVhUcaRRgm9HjZUijluBb8AXm3qWpMB0IcmDvMdKQYL/xd/qzcQSlOV1wQppxKyWR1AxsqX9/0keWk1W4aVZuWB+PquRVEkqqzMNb3kEK4xz4pGQzxvZDFSbz3YThcIRpSb18HkKw1at3oqjKwFOJy0NETopprw3zHahrqiri9MXLPIzdg/AxkALX/cqTRGxOc6wohfdfoZ+2TamXd/cmupHf6qnvjMMAKLPPfobhLJZRpTIUTtpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NIg4Pu4Mtf0ljvFgY0Bsi80+0IT07AWnYeSlB91akHQ=;
 b=g282+gl2kKsGxoSwIqFI5W3Ps+9NPrv+OLK4EMShcsQVwYcrooHjri7fWaHjcLZLIqbdyHuHaZYq7w2Bups4SFLASgMPRO2sixjFpwBQz5nAf6uUQ4dUY0PEUcVDZO0ZSebc2jnAqPGRIX25c5kk+KtSeBver/+WfcpiUDRwUHM=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by DM4PR21MB3441.namprd21.prod.outlook.com (2603:10b6:8:ac::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.0; Wed, 8 Feb
 2023 01:04:20 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::55a1:c339:a0fb:6bbf]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::55a1:c339:a0fb:6bbf%8]) with mapi id 15.20.6111.002; Wed, 8 Feb 2023
 01:04:19 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     "lirongqing@baidu.com" <lirongqing@baidu.com>,
        "seanjc@google.com" <seanjc@google.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] clockevents/drivers/i8253: Do not zero timer counter in
 shutdown
Thread-Topic: [PATCH] clockevents/drivers/i8253: Do not zero timer counter in
 shutdown
Thread-Index: AQHZOpLxbV+L28WTRU2RxqUIZ1Q90K7EObyw
Date:   Wed, 8 Feb 2023 01:04:19 +0000
Message-ID: <BYAPR21MB168840B3814336ED510845C0D7D89@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1675732476-14401-1-git-send-email-lirongqing@baidu.com>
In-Reply-To: <1675732476-14401-1-git-send-email-lirongqing@baidu.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=2964e3f6-ea43-4ab9-892a-9a1b29336c2d;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-02-08T00:51:13Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|DM4PR21MB3441:EE_
x-ms-office365-filtering-correlation-id: 60684c1e-175e-4cef-7e2a-08db0970682c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pVzXCUPjV2YcOiEc2jrGaKlygixxqnfwlPmyTA25ynIy1SoQnczVJwShHYngxKsmEAXsmZmQ9KWfETor441mgsPwUwgdXj9plasHEhbaeRDtUkZF8sUJESyILaK4LJKeAhWtOJEyWd1ItXL92YeUF3TvmD6JIxcJCl+FmT9B4Gt1Bvykh5D1zZiQV8EY2A/KPEx18CPoi9A0PbRVeVq64AetNZhOWKMx/LFZk5vMscnJJKgGH8qfrRr07o8Z2WPQaUC/ln+j59tqYJ45FcSoCf/9rvKobHnxX5RHViLk+uGX8JiZwh8nHm0BVVQTp/1sRX2+a7jJBDVXds0zzFKZxG9vQxLQoxWyPD/LWnmBIdwlQaxI3BNHa9dD5USFIt34pbXhunhM2AgnaVGGobQandZmyzVDgKDhMSbKqhtPcPx4f4lk/G86epib7lBIZhLgtLEyUkZpag8sTVyjhP/Usst6cimLl+NREUJrIN/M0jGX64o5JO2y7DQqzRabbrcn9I1X0H2sB0uTXTVTu+7VzJQg2nFgW2GGakpYRCqEyxPQcXadZvAgYlCCeMOS6ZKztmZ9Vy1glAvUTQffaVq5fnR96/iyOLVaMBkio/6X4Rh1l1NbS4Xn09n8OHjngA1kqEvYDtFgoZyBUpflH1pyIuitUzLpMoRuvhtKocYq7pF43OpuMWr+WJjvaYduvWShi+qZGN3rrgDG6+bKZhYsJncXFgqUXNUHplMqqR61zDRi2RxhjuyDJoDsdqgTZi63G/sLtYq3hcLopvvC9DgM0w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(39860400002)(136003)(366004)(396003)(451199018)(110136005)(316002)(10290500003)(83380400001)(52536014)(55016003)(2906002)(66446008)(7416002)(5660300002)(921005)(38070700005)(8936002)(33656002)(66476007)(8990500004)(38100700002)(76116006)(64756008)(122000001)(8676002)(82950400001)(66556008)(82960400001)(66946007)(41300700001)(9686003)(26005)(7696005)(478600001)(6506007)(186003)(86362001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SBLTPy2LJirEd8YbMZverFyaXRQugurwhqs0ak1VDCJ93qiSRJVF4LUB4eRu?=
 =?us-ascii?Q?BPKYocInnTUdJaH1/hFLki+BcmZFXXz4axs1VheAetmgWOxoZ5I3MouS4crU?=
 =?us-ascii?Q?EkP/1VzSdSGuI5zMfncRen9EI2jBYCptxj7IskUFUgYDcbieKE0+t1DlvdyS?=
 =?us-ascii?Q?IT46G1mA3N7PD/iazeJOpxqe6hLKfRsbEqJEEICR/eq7h+WMFS/BQE+B0rrI?=
 =?us-ascii?Q?WqsGVEeaOYOTVrfx6EMn040rXtFv2zl10uqAyjDsEtx2OznmFqTQy9VvqK97?=
 =?us-ascii?Q?/6eRYqzlMGcojwlPHackMA4bVasbJ2zZF1CHGcyN+2N4s0uzok/z9DqH04vh?=
 =?us-ascii?Q?mMyyTWreWG7Z0Oy7i9aiVVZUu17bKXLLkPAo2npIcIICc1tM13ww/ci5KCBA?=
 =?us-ascii?Q?PUai93AHh+mERT4qcCJtGrjiVnE4db6oWW3EzFntUMwpfodX4F09OLYIAtOl?=
 =?us-ascii?Q?gDTQ08GXQPRas4IYoGBXseif/GyM1X3UTsM176E7wPRWLSNXDki10Ujicaf8?=
 =?us-ascii?Q?6w9YJ4ASaXfk9ErCKbqC4ZpecZbhdr/6U9IbdWUxJPHfer55r46FCGTBOiaz?=
 =?us-ascii?Q?N+VevLRTLKnnkmBnYGuSIOnM5x9gmEHSbn/Ho5HUtjo5wSkGCNg3J+a138bD?=
 =?us-ascii?Q?lBVBIUOOs4l1VTja1EODp5XLuZWGB5O9FsUyjJGVzTMtwqhOgu0cGEjeY0Of?=
 =?us-ascii?Q?UDAwFETAXc1uwbPDRFfnzN0i2P3LonmE58gXQei4iFRfICG6e9u7nuTGk7vg?=
 =?us-ascii?Q?3EaPNMkbUr4K8t9/KhSZdNyKP1Y4W+xYga+wlQ+fA2Vxf1/l/Umq+GBLzjDN?=
 =?us-ascii?Q?Q5Yc8lS7IHl4Y3hU8pHn62UWYL7RsHlx4FB4XIeeG7fBNssKF8QWHoPLRnxv?=
 =?us-ascii?Q?YwVJDOPBUl8LOqIRJGp+4WuMBA0/H43yZbbLNG+DQrXdbi/qmoReC6pa4Xwq?=
 =?us-ascii?Q?0sevxvWnKHZGYSZ5YFmUQthuTVpP3UuSIuQIgDpzJqxdUHj8k5LnykxTHLHh?=
 =?us-ascii?Q?nQP2jzfbhhgAqiaQczeGEBAsYf5LHRN1ocwqEp4kGBxL6VkboBfHe4fi0PGQ?=
 =?us-ascii?Q?/xJ/Nvmj708t6OguqOPVPiBeYyCGht8mqRBv6QrHydy1pOfB52ymD1hx+Prw?=
 =?us-ascii?Q?ushYmL7C7TmVFPgBCU8BW4JZBkQeFNm9k2TAWab6TqDC4Vk5+Yg6mBlKdflW?=
 =?us-ascii?Q?Oluu9o2g5brbsnbE2VUxeXMwTudYlg3va9wuotLtSVr5MtgabWdvSGdDg9wC?=
 =?us-ascii?Q?D0B+CSTOxwMFot6DbHXGCS+nh44maOdeZiDqc/24HDTNzNtX71NGwFiHNY7a?=
 =?us-ascii?Q?wwuWm+QKSiJa+tuIR1rUY72sS/8dFUgYsKFK3X9qhWFIv1kBAtJPoKrB4dtK?=
 =?us-ascii?Q?Wx/D5PNrE3VQ8IGxQbWIlWmhFBvUwnh9VHT1FdX7NTSFbsy6KhK1M5mvN1GY?=
 =?us-ascii?Q?9RkgR+6w8P+nssvD7ni7dAOMflGGNkjYtYRnNPYRA9hHow2IPIDR8J2t6nLS?=
 =?us-ascii?Q?OFTerTmgPagvJWKzn8qIvaM8HC3taezMhriVoXUU/jFuxWsg1dIzJ7JH3VKd?=
 =?us-ascii?Q?VSYr23C/PUYevBPAxdSiXYD0nLXhdR+LOQpY47LZLsCJeX/f0rmMY/nygOne?=
 =?us-ascii?Q?Gg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60684c1e-175e-4cef-7e2a-08db0970682c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2023 01:04:19.1478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YH2qtu+W9QXPUJL/qJSL5NT0ZP5Lw2FYxZ1gk/QF40emL/bZs34Sp5JmcSQaKdTBjRpGzpi8H366mTtTTEmKLDpS1F0iDvFmjkfKvreEc1Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR21MB3441
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: lirongqing@baidu.com <lirongqing@baidu.com> Sent: Monday, February 6,=
 2023 5:15 PM
>=20
> Zeroing the counter register in pit_shutdown() isn't actually supposed to
> stop it from counting,  will causes the PIT to start running again,
> From the spec:
>=20
>   The largest possible initial count is 0; this is equivalent to 216 for
>   binary counting and 104 for BCD counting.
>=20
>   The Counter does not stop when it reaches zero. In Modes 0, 1, 4, and 5=
 the
>   Counter "wraps around" to the highest count, either FFFF hex for binary
>   count- ing or 9999 for BCD counting, and continues counting.
>=20
>   Mode 0 is typically used for event counting. After the Control Word is
>   written, OUT is initially low, and will remain low until the Counter
>   reaches zero. OUT then goes high and remains high until a new count or =
a
>   new Mode 0 Control Word is written into the Counter.
>=20
> Hyper-V and KVM follow the spec, the issue that 35b69a42 "(clockevents/dr=
ivers/
> i8253: Add support for PIT shutdown quirk") fixed is in i8253 drivers, no=
t Hyper-v,
> so delete the zero timer counter register in shutdown, and delete PIT shu=
tdown
> quirk for Hyper-v

From the standpoint of Hyper-V, I'm good with this change.  But there's a
risk that old hardware might not be compliant with the spec, and needs the
zero'ing for some reason. The experts in the x86 space will be in the best
position to assess the risk.  At the time, the quirk approach was taken so
the change applied only to Hyper-V, and any such risk was avoided.

For Hyper-V,
Reviewed-by: Michael Kelley <mikelley@microsoft.com>

>=20
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>  arch/x86/kernel/cpu/mshyperv.c | 11 -----------
>  drivers/clocksource/i8253.c    | 12 ------------
>  include/linux/i8253.h          |  1 -
>  3 files changed, 24 deletions(-)
>=20
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyper=
v.c
> index 46668e2..f788889 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -16,7 +16,6 @@
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
>  #include <linux/kexec.h>
> -#include <linux/i8253.h>
>  #include <linux/random.h>
>  #include <linux/swiotlb.h>
>  #include <asm/processor.h>
> @@ -399,16 +398,6 @@ static void __init ms_hyperv_init_platform(void)
>  	if (efi_enabled(EFI_BOOT))
>  		x86_platform.get_nmi_reason =3D hv_get_nmi_reason;
>=20
> -	/*
> -	 * Hyper-V VMs have a PIT emulation quirk such that zeroing the
> -	 * counter register during PIT shutdown restarts the PIT. So it
> -	 * continues to interrupt @18.2 HZ. Setting i8253_clear_counter
> -	 * to false tells pit_shutdown() not to zero the counter so that
> -	 * the PIT really is shutdown. Generation 2 VMs don't have a PIT,
> -	 * and setting this value has no effect.
> -	 */
> -	i8253_clear_counter_on_shutdown =3D false;
> -
>  #if IS_ENABLED(CONFIG_HYPERV)
>  	/*
>  	 * Setup the hook to get control post apic initialization.
> diff --git a/drivers/clocksource/i8253.c b/drivers/clocksource/i8253.c
> index d4350bb..169474d 100644
> --- a/drivers/clocksource/i8253.c
> +++ b/drivers/clocksource/i8253.c
> @@ -20,13 +20,6 @@
>  DEFINE_RAW_SPINLOCK(i8253_lock);
>  EXPORT_SYMBOL(i8253_lock);
>=20
> -/*
> - * Handle PIT quirk in pit_shutdown() where zeroing the counter register
> - * restarts the PIT, negating the shutdown. On platforms with the quirk,
> - * platform specific code can set this to false.
> - */
> -bool i8253_clear_counter_on_shutdown __ro_after_init =3D true;
> -
>  #ifdef CONFIG_CLKSRC_I8253
>  /*
>   * Since the PIT overflows every tick, its not very useful
> @@ -117,11 +110,6 @@ static int pit_shutdown(struct clock_event_device *e=
vt)
>=20
>  	outb_p(0x30, PIT_MODE);
>=20
> -	if (i8253_clear_counter_on_shutdown) {
> -		outb_p(0, PIT_CH0);
> -		outb_p(0, PIT_CH0);
> -	}
> -
>  	raw_spin_unlock(&i8253_lock);
>  	return 0;
>  }
> diff --git a/include/linux/i8253.h b/include/linux/i8253.h
> index 8336b2f..e6bb36a 100644
> --- a/include/linux/i8253.h
> +++ b/include/linux/i8253.h
> @@ -21,7 +21,6 @@
>  #define PIT_LATCH	((PIT_TICK_RATE + HZ/2) / HZ)
>=20
>  extern raw_spinlock_t i8253_lock;
> -extern bool i8253_clear_counter_on_shutdown;
>  extern struct clock_event_device i8253_clockevent;
>  extern void clockevent_i8253_init(bool oneshot);
>=20
> --
> 2.9.4

