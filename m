Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0A5D25F32A
	for <lists+linux-hyperv@lfdr.de>; Mon,  7 Sep 2020 08:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgIGGbA (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 7 Sep 2020 02:31:00 -0400
Received: from mail-eopbgr1310125.outbound.protection.outlook.com ([40.107.131.125]:50000
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725823AbgIGGa7 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 7 Sep 2020 02:30:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HoyP7+vNbX1FCm+Zqe4Yki88gpz/8+Gy1U0CIHBoDu4mEIv3cnU7jcoV9pBrGE1N049iwwtOCax917cbOV2Kzfzu9hjpJ5wDOAlfy52qWsks5/jsc62XSUNbHhXN3TB0VaxYLg/yeY/utUkhOI+X7HmpdKP8HjtLslSVcJuGfRJ9Wt0Bue2DNAouCtfd2nMsiAJzRHXkLpuG27PEIBpzr5OfLjwBNzV5AFcWXkeSVlqRqqRdbvAg/ekx970xola5J/P/iCXceIXhfFpS8fbOmWWev5RrIJiUTQ69d35PghpewZ8+fU34HcKJ/pLpr34C+uuWdiKkj46BTD8Rn0Y4ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3PCMxeJsmyDGnQkGWQIC0tvWy6MBa1bRGEmDr02x3LQ=;
 b=jB+fekBk9YzuCYzwVOOuc3tAsdT8CzDeCT4hrCkdHM2J/ZDl4rwxPOk0/89HYSnBD2Ed2b1KX2niX3iywygGYSI6n6eem9VAEUYQfxYB4jRb7ITT3BhgNkrzT2ddF/xrXa78FtBYRpgVTwr3gCIXtodyCdcZoWmGTtHV2UkbmY8JHybDDjhPbhe51QctbsVu4Jb6en/PoS2M2aT8TFUY7sbjr3pnD5uV4acKPgjldDRP9YSVhIgUCq1DJxJGmimBJ5yX92wn7pUaJ1HthIsNp5DUMnPY2pOJMs8mwaBnQiDMXjcAb+3ehG7CnVIxSBWcaOcQOR0jqAb2aGl23WsPVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3PCMxeJsmyDGnQkGWQIC0tvWy6MBa1bRGEmDr02x3LQ=;
 b=QjObz1imAIfd/IjbAmcp2TaR0m+dBRuy7e+/T6eWkEiFf5bb3+gll6Q1tpC9CSQn3wex283bqfbWjjE94lQdfHFB9iB/IgJmpElELEXUIu028efJ6kIr9FIG1U7icF74011n9HD3cYRD49vQsCyuvNqZ1QNWnzkj2N8ajv/71zg=
Received: from KU1P153MB0120.APCP153.PROD.OUTLOOK.COM (2603:1096:802:1a::17)
 by KU1P153MB0200.APCP153.PROD.OUTLOOK.COM (2603:1096:802:2a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.3; Mon, 7 Sep
 2020 06:30:48 +0000
Received: from KU1P153MB0120.APCP153.PROD.OUTLOOK.COM
 ([fe80::800c:633d:2d74:4f61]) by KU1P153MB0120.APCP153.PROD.OUTLOOK.COM
 ([fe80::800c:633d:2d74:4f61%5]) with mapi id 15.20.3391.003; Mon, 7 Sep 2020
 06:30:48 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "allison@lohutok.net" <allison@lohutok.net>,
        "alexios.zavras@intel.com" <alexios.zavras@intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "namit@vmware.com" <namit@vmware.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Long Li <longli@microsoft.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: RE: [RESEND][PATCH v3] x86/apic/flat64: Add back the
 early_param("apic", parse_apic)
Thread-Topic: [RESEND][PATCH v3] x86/apic/flat64: Add back the
 early_param("apic", parse_apic)
Thread-Index: AQHWXDqcBL16zQ0AeEGLYyUOD3kNpalccIfQ
Date:   Mon, 7 Sep 2020 06:30:47 +0000
Message-ID: <KU1P153MB01207E71069B0883E44218E4BF280@KU1P153MB0120.APCP153.PROD.OUTLOOK.COM>
References: <20200626182106.57219-1-decui@microsoft.com>
 <87mu3ys391.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87mu3ys391.fsf@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=9a8210d2-6baa-4293-a33a-cc8a3a861df6;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-09-06T21:27:16Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none
 header.from=microsoft.com;
x-originating-ip: [2601:600:105:f217:6c5f:7d2:8c52:e817]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0684c8e4-2046-4788-bc0a-08d852f78ef4
x-ms-traffictypediagnostic: KU1P153MB0200:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <KU1P153MB0200C0A528C76B26E545DF6CBF280@KU1P153MB0200.APCP153.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jJafX5rQwxWzQbikTlUMcwyghxKiKAOBBMO4PryG1X6U6+nGmHvubr1LHi+Ldv/ZBXTnVuJimzvijp1Xs/iQ1dnGaAhqza002GXJJoQgVIMeVflrF9ssYyTPcf4auguI3jD1J7Z6yHwOSfFAWxHEE+i3JRJc15NDoHi4FhNYAZEwBoeGAGFo4rAeyIGaHyiILXH9IBRklBG92bkzbXUKjtE1LEOG29ywDFwnYXXBmPzl6tqZ/T6pIp+MFyTHbntqyOUdfK2GkUn8TXaW4OkHv1vkRGVCCJar24r4KPnO6rTfhYSrtGE0o+0LsqBHADlbiEuPKCjv5nMWsOUBmm/MxHE7nQwoZXLZAfgF3TuOweVy18DynzPirkGTsmZujgNR8xOcvXB1NNFAEz9e8d/VH5DuA2VIxSBP/nnqTkv/reY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KU1P153MB0120.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(396003)(366004)(376002)(136003)(33656002)(5660300002)(4326008)(54906003)(52536014)(7696005)(6506007)(4744005)(110136005)(478600001)(2906002)(316002)(8676002)(8936002)(6636002)(9686003)(66476007)(66446008)(55016002)(7416002)(64756008)(82960400001)(66946007)(10290500003)(71200400001)(82950400001)(76116006)(66556008)(186003)(8990500004)(86362001)(921003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: afr8yxZtMx079Zrkj/rIbWdI5NvkM8lU9YDzEzpDPhTG7LtxfSha6hb/c3ohrXssgZZfvWsr1oA0Zy3AptzrA0vhr33r/GzE4rLE1vJjeepdKZPMFDc+oP0D1EAQ0R5Mc87EYwV9qvxSbKGBDHSNsn5ywjsgdGtcDjBJymStB+eNE65ittYwQJNVhoKNOAaBdCUfwEPdKvOSuuqHYTDftZk47euuWqqLR50vo48kte2SYH/2UrII/2jjl7Vn9WMO2OQAfkSjFpi2q0uP6GiwoKIpEtNQvdAjzqm8QSfP5XL8O3CiyjfuYiljdBjPVsFKlGRj9PMV5oBwthjpnG414fsGZlEgTU1GkZPReCbQ8NvFqievbBxGaukR2iyxRByMGn/Ioz8ijYJN2V3JpAgYv8QwX1+6Jln//uTqkX++paypvHGQaSHpJ+aKONpjEViawpewTIbjGbTFlUuAam+XPb81l5pOiSgj8Xx8lFEHMCQtaeYOl1W5g2wZGXpzSevyEQ179UZDlAutpRnEeG7U0wAvKzmaom3DH6/nzT/ieM/a2RkTWHVXMiuKddwCrcrVGsr/GYPoxxrVbTixUhwiGOd8AGLMw9QQDwGMeaTCmdp3ntmn7Ex9+0xTDG7EGLQ1jD8zaeniMep9uUqwzMGdUZMMKfTFKS3pUJE/TzZ8zEasYEVPwCVfcVM54kOGApfkG4NVxGOT1C7SqWth9bUTuw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KU1P153MB0120.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0684c8e4-2046-4788-bc0a-08d852f78ef4
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2020 06:30:47.5901
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z7bV8hdAQc5zL33A1ZWOV+73q6aRbv4E4C1AYG1b1nKkVvP7NPYGEZ2k/9LJbgr9dcIv9D5sdooJ29TjXizuLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU1P153MB0200
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

> From: Thomas Gleixner <tglx@linutronix.de>
> Sent: Friday, July 17, 2020 6:03 AM
> [...]
Hi, I'm very sorry for this extremely late reply -- I was sidetracked by so=
mething
else and I just had a chance to revisit the issue. Thank you tglx for the c=
omments
and suggestions, which I think are reasonable. I realized this patch is pro=
blematic.
The good news is that the LAPIC emulation bug has been fixed in the latest =
version
of Hyper-V and now kdump can work reliably. I think the hypervisor fix woul=
d be=20
backported to old Hyper-V versions, so hopefully this won't be an issue ove=
r time.

Thanks,
-- Dexuan
