Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D57E717BF9
	for <lists+linux-hyperv@lfdr.de>; Wed, 31 May 2023 11:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235537AbjEaJcG (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 31 May 2023 05:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235532AbjEaJbo (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 31 May 2023 05:31:44 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0B4C0;
        Wed, 31 May 2023 02:31:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 29C301FD60;
        Wed, 31 May 2023 09:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1685525498; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mox8b8vT26odzKQfKkw1K7+Wm+UZ8eqz7llUI5QSg8k=;
        b=XHf9+pOGBRfbmMpO/UW1ImDja3XOHYMcBAGANh+plWQZYcP+04FA04kjxV8Cs9OwHXCFMJ
        F/UbrXGweXVe5Ldge+07IP1xWhvNIN32962WuzFPB9TlC1Z3H8g8jBhabC6NJghxTLEi7N
        8qiT0i0qhCHsTnxycZ/QtSwx8vM/Y8Y=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 83FD9138E8;
        Wed, 31 May 2023 09:31:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VFmeHvkTd2TEAgAAMHmgww
        (envelope-from <jgross@suse.com>); Wed, 31 May 2023 09:31:37 +0000
Message-ID: <7e824a95-6676-9553-4158-d434f617fcbb@suse.com>
Date:   Wed, 31 May 2023 11:31:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-hyperv@vger.kernel.org, linux-doc@vger.kernel.org,
        mikelley@microsoft.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org, Jonathan Corbet <corbet@lwn.net>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <20230502120931.20719-1-jgross@suse.com>
 <20230509201437.GFZFqprc6otRejDPUt@fat_crate.local>
 <20230509233641.GGZFrZCTDH7VwUMp5R@fat_crate.local>
 <20230510133024.GBZFuccC1FxIZNKL+8@fat_crate.local>
 <4c47a11c-0565-678d-3467-e01c5ec16600@suse.com>
 <20230511163208.GDZF0YiOfxQhSo4RDm@fat_crate.local>
 <0cd3899b-cf3b-61c1-14ae-60b6b49d14ab@suse.com>
 <20230530152825.GAZHYWGXAp8PHgN/w0@fat_crate.local>
 <888f860d-4307-54eb-01da-11f9adf65559@suse.com>
 <20230531083508.GAZHcGvB68PUAH7f+a@fat_crate.local>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v6 00/16] x86/mtrr: fix handling with PAT but without MTRR
In-Reply-To: <20230531083508.GAZHcGvB68PUAH7f+a@fat_crate.local>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------24GFxpKYKP5BZzRRH60QZsvv"
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------24GFxpKYKP5BZzRRH60QZsvv
Content-Type: multipart/mixed; boundary="------------fNJfB2Tgxipl1Nkv6U8O5K3b";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-hyperv@vger.kernel.org, linux-doc@vger.kernel.org,
 mikelley@microsoft.com, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 xen-devel@lists.xenproject.org, Jonathan Corbet <corbet@lwn.net>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Message-ID: <7e824a95-6676-9553-4158-d434f617fcbb@suse.com>
Subject: Re: [PATCH v6 00/16] x86/mtrr: fix handling with PAT but without MTRR
References: <20230502120931.20719-1-jgross@suse.com>
 <20230509201437.GFZFqprc6otRejDPUt@fat_crate.local>
 <20230509233641.GGZFrZCTDH7VwUMp5R@fat_crate.local>
 <20230510133024.GBZFuccC1FxIZNKL+8@fat_crate.local>
 <4c47a11c-0565-678d-3467-e01c5ec16600@suse.com>
 <20230511163208.GDZF0YiOfxQhSo4RDm@fat_crate.local>
 <0cd3899b-cf3b-61c1-14ae-60b6b49d14ab@suse.com>
 <20230530152825.GAZHYWGXAp8PHgN/w0@fat_crate.local>
 <888f860d-4307-54eb-01da-11f9adf65559@suse.com>
 <20230531083508.GAZHcGvB68PUAH7f+a@fat_crate.local>
In-Reply-To: <20230531083508.GAZHcGvB68PUAH7f+a@fat_crate.local>

--------------fNJfB2Tgxipl1Nkv6U8O5K3b
Content-Type: multipart/mixed; boundary="------------FtQlGK5DGcgDrf3eg8wUr71y"

--------------FtQlGK5DGcgDrf3eg8wUr71y
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMzEuMDUuMjMgMTA6MzUsIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gT24gV2VkLCBN
YXkgMzEsIDIwMjMgYXQgMDk6Mjg6NTdBTSArMDIwMCwgSnVlcmdlbiBHcm9zcyB3cm90ZToN
Cj4+IENhbiB5b3UgcGxlYXNlIGJvb3QgdGhlIHN5c3RlbSB3aXRoIHRoZSBNVFJSIHBhdGNo
ZXMgYW5kIHNwZWNpZnkgIm10cnI9ZGVidWciDQo+PiBvbiB0aGUgY29tbWFuZCBsaW5lPyBJ
J2QgYmUgaW50ZXJlc3RlZCBpbiB0aGUgcmF3IHJlZ2lzdGVyIHZhbHVlcyBiZWluZyByZWFk
DQo+PiBhbmQgdGhlIHJlc3VsdGluZyBtZW1vcnkgdHlwZSBtYXAuDQo+IA0KPiBUaGlzIGlz
IGV4YWN0bHkgd2h5IEkgd2FudGVkIHRoaXMgb3B0aW9uLiBBbmQgeW91J3JlIGFscmVhZHkg
cHV0dGluZyBpdA0KPiB0byBnb29kIHVzZS4gOi1QDQo+IA0KPiBGdWxsIGRtZXNnIGJlbG93
Lg0KPiANCj4gWyAgICAwLjAxMjg3OF0gbGFzdF9wZm4gPSAweDQ1MDAwMCBtYXhfYXJjaF9w
Zm4gPSAweDQwMDAwMDAwMA0KPiBbICAgIDAuMDE4MzU3XSBNVFJSIGRlZmF1bHQgdHlwZTog
dW5jYWNoYWJsZQ0KPiBbICAgIDAuMDIyMzQ3XSBNVFJSIGZpeGVkIHJhbmdlcyBlbmFibGVk
Og0KPiBbICAgIDAuMDI2MDg1XSAgIDAwMDAwLTlGRkZGIHdyaXRlLWJhY2sNCj4gWyAgICAw
LjAyOTY1MF0gICBBMDAwMC1CRkZGRiB1bmNhY2hhYmxlDQo+IFsgICAgMC4wMzMyMTRdICAg
QzAwMDAtRkZGRkYgd3JpdGUtcHJvdGVjdA0KPiBbICAgIDAuMDM3MDM5XSBNVFJSIHZhcmlh
YmxlIHJhbmdlcyBlbmFibGVkOg0KPiBbICAgIDAuMDQxMDM4XSAgIDAgYmFzZSAwMDAwMDAw
MDAwMDAwMDAgbWFzayAwMDAzRkZDMDAwMDAwMDAgd3JpdGUtYmFjaw0KDQoxNiBHQiBXQiBh
dCBhZGRyZXNzIDAuDQoNCj4gWyAgICAwLjA0NzM4M10gICAxIGJhc2UgMDAwMDAwNDAwMDAw
MDAwIG1hc2sgMDAwM0ZGRkMwMDAwMDAwIHdyaXRlLWJhY2sNCg0KMSBHQiBXQiBhdCBhZGRy
ZXNzIDE2R0IuDQoNCj4gWyAgICAwLjA1MzczMF0gICAyIGJhc2UgMDAwMDAwNDQwMDAwMDAw
IG1hc2sgMDAwM0ZGRkYwMDAwMDAwIHdyaXRlLWJhY2sNCg0KMjU2TUIgV0IgYXQgYWRkcmVz
cyAxN0dCLg0KDQpUaGlzIG1lYW5zIHBlciBkZWZhdWx0IDAtNDRmZmZmZmZmIGFyZSBXQi4N
Cg0KPiBbICAgIDAuMDYwMDc2XSAgIDMgYmFzZSAwMDAwMDAwQUUwMDAwMDAgbWFzayAwMDAz
RkZGRkUwMDAwMDAgdW5jYWNoYWJsZQ0KDQozMk1CIFVDIGF0IEFFMDAwMDAwDQoNCj4gWyAg
ICAwLjA2NjQyMV0gICA0IGJhc2UgMDAwMDAwMEIwMDAwMDAwIG1hc2sgMDAwM0ZGRkYwMDAw
MDAwIHVuY2FjaGFibGUNCg0KMjU2TUIgVUMgYXQgQjAwMDAwMDANCg0KPiBbICAgIDAuMDcy
NzY4XSAgIDUgYmFzZSAwMDAwMDAwQzAwMDAwMDAgbWFzayAwMDAzRkZGQzAwMDAwMDAgdW5j
YWNoYWJsZQ0KDQo1MTJNQiBVQyBhdCBDMDAwMDAwMA0KDQpTbyBhbiBVQyBob2xlIGF0IEFF
MDAwMDAwLUZGRkZGRkZGLg0KDQo+IFsgICAgMC4wNzkxMTRdICAgNiBkaXNhYmxlZA0KPiBb
ICAgIDAuMDgxNjM1XSAgIDcgZGlzYWJsZWQNCj4gWyAgICAwLjA4NDE1Nl0gICA4IGRpc2Fi
bGVkDQo+IFsgICAgMC4wODY2NzddICAgOSBkaXNhYmxlZA0KPiBbICAgIDAuMDg5MjAzXSB0
b3RhbCBSQU0gY292ZXJlZDogMTYzNTJNDQo+IFsgICAgMC4wOTMwMjNdIEZvdW5kIG9wdGlt
YWwgc2V0dGluZyBmb3IgbXRyciBjbGVhbiB1cA0KDQpJdCBzZWVtcyBhcyBpZiBtdHJyX2Ns
ZWFudXAoKSBkaWQgY2hhbmdlIHRoZSBNVFJSIHNldHRpbmdzLg0KDQpXaGF0IGl0IGRpZCB3
b3VsZCBoYXZlIGJlZW4gcHJpbnRlZCBpZiBwcl9kZWJ1ZygpIHdvdWxkIGhhdmUgYmVlbg0K
YWN0aXZlLiA6LSgNCg0KPiBbICAgIDAuMDk3NzM0XSAgZ3Jhbl9zaXplOiA2NEsgCWNodW5r
X3NpemU6IDY0TSAJbnVtX3JlZzogOCAgCWxvc2UgY292ZXIgUkFNOiAwRw0KPiBbICAgIDAu
MTA0ODY0XSBNVFJSIG1hcDogNiBlbnRyaWVzICgzIGZpeGVkICsgMyB2YXJpYWJsZTsgbWF4
IDIzKSwgYnVpbHQgZnJvbSAxMCB2YXJpYWJsZSBNVFJScw0KPiBbICAgIDAuMTEzMjk0XSAg
IDA6IDAwMDAwMDAwMDAwMDAwMDAtMDAwMDAwMDAwMDA5ZmZmZiB3cml0ZS1iYWNrDQo+IFsg
ICAgMC4xMTkwMzNdICAgMTogMDAwMDAwMDAwMDBhMDAwMC0wMDAwMDAwMDAwMGJmZmZmIHVu
Y2FjaGFibGUNCj4gWyAgICAwLjEyNDc3MV0gICAyOiAwMDAwMDAwMDAwMGMwMDAwLTAwMDAw
MDAwMDAwZmZmZmYgd3JpdGUtcHJvdGVjdA0KPiBbICAgIDAuMTMwNzY5XSAgIDM6IDAwMDAw
MDAwMDAxMDAwMDAtMDAwMDAwMDBhZGZmZmZmZiB3cml0ZS1iYWNrDQo+IFsgICAgMC4xMzY1
MDhdICAgNDogMDAwMDAwMDBhZTAwMDAwMC0wMDAwMDAwMGFmZmZmZmZmIHVuY2FjaGFibGUN
Cj4gWyAgICAwLjE0MjI0Nl0gICA1OiAwMDAwMDAwMTAwMDAwMDAwLTAwMDAwMDA0NGZmZmZm
ZmYgd3JpdGUtYmFjaw0KDQpUaGUgTVRSUiBtYXAgc2VlbXMgdG8gYmUgZmluZSBhc3N1bWlu
ZyB0aGUgTVRSUiB2YWx1ZXMgYmVmb3JlIHRoZSAiY2xlYW4gdXAiLg0KDQo+IFsgICAgMC4x
NDc5OTJdIHg4Ni9QQVQ6IENvbmZpZ3VyYXRpb24gWzAtN106IFdCICBXQyAgVUMtIFVDICBX
QiAgV1AgIFVDLSBXVA0KID4gWyAgICAwLjE1NTEyMl0gZTgyMDogdXBkYXRlIFttZW0gMHhh
ZTAwMDAwMC0weGFmZmZmZmZmXSB1c2FibGUgPT0+IHJlc2VydmVkDQogPiBbICAgIDAuMTYx
NjYzXSBlODIwOiB1cGRhdGUgW21lbSAweGMwMDAwMDAwLTB4ZmZmZmZmZmZdIHVzYWJsZSA9
PT4gcmVzZXJ2ZWQNCiA+IFsgICAgMC4xNjgzNThdIGU4MjA6IHVwZGF0ZSBbbWVtIDB4MTEw
MDAwMDAwLTB4MWZmZmZmZmZmXSB1c2FibGUgPT0+IHJlc2VydmVkDQogPiBbICAgIDAuMTc1
MjI3XSBXQVJOSU5HOiBCSU9TIGJ1ZzogQ1BVIE1UUlJzIGRvbid0IGNvdmVyIGFsbCBvZiBt
ZW1vcnksIGxvc2luZyANCjM4NDBNQiBvZiBSQU0uDQoNCkNsZWFuIHVwIG1lc3NlZCB3aXRo
IHRoZSBzZXR0aW5ncywgcmVzdWx0aW5nIGluIGxvc3Mgb2YgUkFNLg0KDQpEaWQgeW91IGNo
ZWNrIHdoZXRoZXIgQ09ORklHX01UUlJfU0FOSVRJWkVSX0VOQUJMRV9ERUZBVUxUIHdhcyB0
aGUgc2FtZSBpbiBib3RoDQprZXJuZWxzIHlvdSd2ZSB0ZXN0ZWQ/DQoNCg0KSnVlcmdlbg0K

--------------FtQlGK5DGcgDrf3eg8wUr71y
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------FtQlGK5DGcgDrf3eg8wUr71y--

--------------fNJfB2Tgxipl1Nkv6U8O5K3b--

--------------24GFxpKYKP5BZzRRH60QZsvv
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmR3E/kFAwAAAAAACgkQsN6d1ii/Ey/M
zggAisVIrCMiJz4WLPmjaKUQvAvIDD1xoFhCVf0VE6jtX7FC8FZVkAcm0QuoOjxlMI1ST5zjxMqR
AW2F05GHDq6rL7ufLu0j/vprfRU6qdIZhQKbOGM1AKi//VpxNpES3zfp+M7szAOgy/HclR1DI6Hb
SWDV7ze+q5bcRAb8tO0Fwl5ZqG/t4LJMFxJP5o1sPoeFZwPId9R4F5ydUBzdZxQDzQCCsKSexZmY
Fw7ubqFWUEr9QGecs6CcjtyaYiwAHxsfG+nihd0+WZT8L/4usDxVdgEOkMZZHk5pzVq31HBReTAx
zoAPOHex5tpy+obQWQwz3OdZwG02MhbI9fw0eN3Eag==
=Y4Ws
-----END PGP SIGNATURE-----

--------------24GFxpKYKP5BZzRRH60QZsvv--
