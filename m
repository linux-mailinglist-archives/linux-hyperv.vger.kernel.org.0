Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA25693E43
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Feb 2023 07:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjBMG2Y (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 13 Feb 2023 01:28:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjBMG2X (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 13 Feb 2023 01:28:23 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ABEADBF3;
        Sun, 12 Feb 2023 22:28:22 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CC72E5D55F;
        Mon, 13 Feb 2023 06:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1676269700; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sETX0ikXPsCWRx8hcdFRpKcfWChxGPPrO0PQTEy6sH0=;
        b=szTBSMRdtdAskfJ+9mrVdXpdJdgD9ghRvZte0PhdLUACNpqvqXYNNc0fUipAvl8TmBfhLT
        lEpnfB0QJApv1+WkWYu6UsPg378V+5O1WZq1wojOJ+PQ/y/zdZnXJGxkSbXk0h4R7y0VCr
        f6KJijO30SHKdg8Y5ovJD3nNzfxwGwo=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6046E1391B;
        Mon, 13 Feb 2023 06:28:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FYwOFoTY6WNmBQAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 13 Feb 2023 06:28:20 +0000
Message-ID: <41ce06c9-df2e-3348-f5bc-ae5925adaa2a@suse.com>
Date:   Mon, 13 Feb 2023 07:28:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 3/8] x86/hyperv: set MTRR state when running as SEV-SNP
 Hyper-V guest
Content-Language: en-US
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Cc:     "lists@nerdbynature.de" <lists@nerdbynature.de>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20230209072220.6836-1-jgross@suse.com>
 <20230209072220.6836-4-jgross@suse.com>
 <BYAPR21MB1688C2A893BA9D2A14D729DFD7DD9@BYAPR21MB1688.namprd21.prod.outlook.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <BYAPR21MB1688C2A893BA9D2A14D729DFD7DD9@BYAPR21MB1688.namprd21.prod.outlook.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------j6hy8BDP0jRbkBvVTKuRu7Si"
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------j6hy8BDP0jRbkBvVTKuRu7Si
Content-Type: multipart/mixed; boundary="------------8OmGzH5fFTEECazp0q0VVbzh";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Cc: "lists@nerdbynature.de" <lists@nerdbynature.de>,
 "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
 KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <41ce06c9-df2e-3348-f5bc-ae5925adaa2a@suse.com>
Subject: Re: [PATCH v2 3/8] x86/hyperv: set MTRR state when running as SEV-SNP
 Hyper-V guest
References: <20230209072220.6836-1-jgross@suse.com>
 <20230209072220.6836-4-jgross@suse.com>
 <BYAPR21MB1688C2A893BA9D2A14D729DFD7DD9@BYAPR21MB1688.namprd21.prod.outlook.com>
In-Reply-To: <BYAPR21MB1688C2A893BA9D2A14D729DFD7DD9@BYAPR21MB1688.namprd21.prod.outlook.com>

--------------8OmGzH5fFTEECazp0q0VVbzh
Content-Type: multipart/mixed; boundary="------------yt0MkDa4rcsx94tvgyi0k729"

--------------yt0MkDa4rcsx94tvgyi0k729
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTMuMDIuMjMgMDI6MDcsIE1pY2hhZWwgS2VsbGV5IChMSU5VWCkgd3JvdGU6DQo+IEZy
b206IEp1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT4gU2VudDogV2VkbmVzZGF5LCBG
ZWJydWFyeSA4LCAyMDIzIDExOjIyIFBNDQo+Pg0KPj4gSW4gb3JkZXIgdG8gYXZvaWQgbWFw
cGluZ3MgdXNpbmcgdGhlIFVDLSBjYWNoZSBhdHRyaWJ1dGUsIHNldCB0aGUNCj4+IE1UUlIg
c3RhdGUgdG8gdXNlIFdCIGNhY2hpbmcgYXMgdGhlIGRlZmF1bHQuDQo+Pg0KPj4gVGhpcyBp
cyBuZWVkZWQgaW4gb3JkZXIgdG8gY29wZSB3aXRoIHRoZSBmYWN0IHRoYXQgUEFUIGlzIGVu
YWJsZWQsDQo+PiB3aGlsZSBNVFJScyBhcmUgZGlzYWJsZWQgYnkgdGhlIGh5cGVydmlzb3Iu
DQo+Pg0KPj4gRml4ZXM6IDkwYjkyNmU2OGY1MCAoIng4Ni9wYXQ6IEZpeCBwYXRfeF9tdHJy
X3R5cGUoKSBmb3IgTVRSUiBkaXNhYmxlZCBjYXNlIikNCj4+IFNpZ25lZC1vZmYtYnk6IEp1
ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT4NCj4+IC0tLQ0KPj4gVjI6DQo+PiAtIG5l
dyBwYXRjaA0KPj4gLS0tDQo+PiAgIGFyY2gveDg2L2tlcm5lbC9jcHUvbXNoeXBlcnYuYyB8
IDggKysrKysrKysNCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKQ0KPj4N
Cj4+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L21zaHlwZXJ2LmMgYi9hcmNo
L3g4Ni9rZXJuZWwvY3B1L21zaHlwZXJ2LmMNCj4+IGluZGV4IDQ2NjY4ZTI1NTQyMS4uNTFl
NDdkYzBlOTg3IDEwMDY0NA0KPj4gLS0tIGEvYXJjaC94ODYva2VybmVsL2NwdS9tc2h5cGVy
di5jDQo+PiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L21zaHlwZXJ2LmMNCj4+IEBAIC0z
NCw2ICszNCw3IEBADQo+PiAgICNpbmNsdWRlIDxjbG9ja3NvdXJjZS9oeXBlcnZfdGltZXIu
aD4NCj4+ICAgI2luY2x1ZGUgPGFzbS9udW1hLmg+DQo+PiAgICNpbmNsdWRlIDxhc20vY29j
by5oPg0KPj4gKyNpbmNsdWRlIDxhc20vbXRyci5oPg0KPj4NCj4+ICAgLyogSXMgTGludXgg
cnVubmluZyBhcyB0aGUgcm9vdCBwYXJ0aXRpb24/ICovDQo+PiAgIGJvb2wgaHZfcm9vdF9w
YXJ0aXRpb247DQo+PiBAQCAtMzM1LDYgKzMzNiwxMyBAQCBzdGF0aWMgdm9pZCBfX2luaXQg
bXNfaHlwZXJ2X2luaXRfcGxhdGZvcm0odm9pZCkNCj4+ICAgCQkJc3RhdGljX2JyYW5jaF9l
bmFibGUoJmlzb2xhdGlvbl90eXBlX3NucCk7DQo+PiAgICNpZmRlZiBDT05GSUdfU1dJT1RM
Qg0KPj4gICAJCQlzd2lvdGxiX3VuZW5jcnlwdGVkX2Jhc2UgPSBtc19oeXBlcnYuc2hhcmVk
X2dwYV9ib3VuZGFyeTsNCj4+ICsjZW5kaWYNCj4gDQo+IFVuZm9ydHVuYXRlbHksIEh5cGVy
LVYgZG9lcyBub3QgZmlsdGVyIG91dCB0aGUgTVRSUiBmbGFnIGZyb20gdGhlDQo+IENQVUlE
IGxlYWYsIHNvIHRoaXMgY29kZSBhbHNvIG5lZWRzDQo+IA0KPiAJCQlzZXR1cF9jbGVhcl9j
cHVfY2FwKFg4Nl9GRUFUVVJFX01UUlIpOw0KPiANCj4gYmVmb3JlIGNhbGxpbmcgbXRycl9v
dmVyd3JpdGVfc3RhdGUoKS4gIEkndmUgZ290IGEgYnVnIGZpbGVkIGZvciB0aGUNCj4gSHlw
ZXItViB0ZWFtIHRvIGZpeCB0aGUgZmxhZywgYnV0IGNsZWFyaW5nIHRoZSBmZWF0dXJlIGhl
cmUgc29sdmVzIHRoZQ0KPiBwcm9ibGVtIHJlZ2FyZGxlc3MuDQoNCk9rYXksIHdpbGwgYWRk
IGl0Lg0KDQo+IA0KPj4gKyNpZmRlZiBDT05GSUdfTVRSUg0KPiANCj4gSG9wZWZ1bGx5IHRo
aXMgI2lmZGVmIGNhbiBnbyBhd2F5LCBwZXIgbXkgY29tbWVudCBpbiBQYXRjaCAyIG9mDQo+
IHRoZSBzZXJpZXMuDQoNCkFzIHNhaWQgYWxyZWFkeSwgZmluZSB3aXRoIG1lLg0KDQoNCkp1
ZXJnZW4NCg==
--------------yt0MkDa4rcsx94tvgyi0k729
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------yt0MkDa4rcsx94tvgyi0k729--

--------------8OmGzH5fFTEECazp0q0VVbzh--

--------------j6hy8BDP0jRbkBvVTKuRu7Si
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmPp2IMFAwAAAAAACgkQsN6d1ii/Ey/E
1Af/VGzydMZsFR52sciEWzeRZFrl9MAkMDXh+IcAee11JNt2fjNdGQwYRTLqkNUPiS6VR5JkryX0
VUf+d2EquETpLbO0hZYnUmF2uw80SLSnMigH+dwo2Td9gFkludfPJqEDVTsZ8J4HnKsCLuPXqzAD
4yKYnTdDvcq9uSqv3P3rzft07XEVRzFR0EY8qEyug97rG0qIQGV460TcdzANwQzMm5rkDaesxSKV
CIWhRLJg7sbzzEy5IqVeHcVfcYkKVh1oRQxbk0NOyy1XM8HA1CP2Pg6Ulm4+j3tHE3h35YpScbto
TE8zD9Vi+TLYJmj5JsfdBcfvNEWXHs0Ob+R3E2JIpw==
=FpFh
-----END PGP SIGNATURE-----

--------------j6hy8BDP0jRbkBvVTKuRu7Si--
