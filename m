Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE656693E14
	for <lists+linux-hyperv@lfdr.de>; Mon, 13 Feb 2023 07:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjBMGMP (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 13 Feb 2023 01:12:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjBMGMO (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 13 Feb 2023 01:12:14 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79835272E;
        Sun, 12 Feb 2023 22:12:12 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3069333736;
        Mon, 13 Feb 2023 06:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1676268731; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BLdwPfB+4D/AiyM/5+E2+N6MgxDwomI5dtk8SFrgHHI=;
        b=Dh4tr5axouvn57uHXUo/tVOszMBnsH+LXCzpAOSNUz61N2ao49WLs5JvpzhqxZc6v6QCuB
        //emi67roNziesAk/rv1qQu7gRqD5yWFYkjlRlhanifbveQMs0sJaDTVxMtOemeMCAz138
        WjCbiHjT352CscnHZ0JDBOuXu5VIM9c=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2FFAD1391B;
        Mon, 13 Feb 2023 06:12:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9j1ZCrrU6WN8fgAAMHmgww
        (envelope-from <jgross@suse.com>); Mon, 13 Feb 2023 06:12:10 +0000
Message-ID: <e983da4b-71d5-1c9d-5efa-be7935dab8fc@suse.com>
Date:   Mon, 13 Feb 2023 07:12:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 0/8] x86/mtrr: fix handling with PAT but without MTRR
Content-Language: en-US
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Cc:     "Ostrovsky, Boris" <boris.ostrovsky@oracle.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "kys@microsoft.com" <kys@microsoft.com>,
        "lists@nerdbynature.de" <lists@nerdbynature.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "Cui, Dexuan" <decui@microsoft.com>,
        "mikelley@microsoft.com" <mikelley@microsoft.com>,
        "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
References: <20230209072220.6836-1-jgross@suse.com>
 <efeaec9b303e8a3ec7a7af826c61669d18fd22dc.camel@intel.com>
From:   Juergen Gross <jgross@suse.com>
In-Reply-To: <efeaec9b303e8a3ec7a7af826c61669d18fd22dc.camel@intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------f1vstKnhITA2oOGQSyz67zP0"
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------f1vstKnhITA2oOGQSyz67zP0
Content-Type: multipart/mixed; boundary="------------ACsfdmS5eSJC8hchh3zvew2M";
 protected-headers="v1"
From: Juergen Gross <jgross@suse.com>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Cc: "Ostrovsky, Boris" <boris.ostrovsky@oracle.com>,
 "peterz@infradead.org" <peterz@infradead.org>,
 "Torvalds, Linus" <torvalds@linux-foundation.org>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "kys@microsoft.com" <kys@microsoft.com>,
 "lists@nerdbynature.de" <lists@nerdbynature.de>,
 "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
 "hpa@zytor.com" <hpa@zytor.com>, "mingo@redhat.com" <mingo@redhat.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>, "Lutomirski, Andy"
 <luto@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
 "Cui, Dexuan" <decui@microsoft.com>,
 "mikelley@microsoft.com" <mikelley@microsoft.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
Message-ID: <e983da4b-71d5-1c9d-5efa-be7935dab8fc@suse.com>
Subject: Re: [PATCH v2 0/8] x86/mtrr: fix handling with PAT but without MTRR
References: <20230209072220.6836-1-jgross@suse.com>
 <efeaec9b303e8a3ec7a7af826c61669d18fd22dc.camel@intel.com>
In-Reply-To: <efeaec9b303e8a3ec7a7af826c61669d18fd22dc.camel@intel.com>

--------------ACsfdmS5eSJC8hchh3zvew2M
Content-Type: multipart/mixed; boundary="------------WIiv0hoECcgZufueRJws0bAS"

--------------WIiv0hoECcgZufueRJws0bAS
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTEuMDIuMjMgMDE6MDYsIEVkZ2Vjb21iZSwgUmljayBQIHdyb3RlOg0KPiBPbiBUaHUs
IDIwMjMtMDItMDkgYXQgMDg6MjIgKzAxMDAsIEp1ZXJnZW4gR3Jvc3Mgd3JvdGU6DQo+PiBU
aGlzIHNlcmllcyB0cmllcyB0byBmaXggdGhlIHJhdGhlciBzcGVjaWFsIGNhc2Ugb2YgUEFU
IGJlaW5nDQo+PiBhdmFpbGFibGUNCj4+IHdpdGhvdXQgaGF2aW5nIE1UUlJzIChlaXRoZXIg
ZHVlIHRvIENPTkZJR19NVFJSIGJlaW5nIG5vdCBzZXQsIG9yDQo+PiBiZWNhdXNlIHRoZSBm
ZWF0dXJlIGhhcyBiZWVuIGRpc2FibGVkIGUuZy4gYnkgYSBoeXBlcnZpc29yKS4NCj4gDQo+
IGRlYnVnX3ZtX3BndGFibGUgZmFpbHMgaW4gYSBLVk0gZ3Vlc3Qgd2l0aCBDT05GSUdfTVRS
Uj15LiBDT05GSUdfTVRSUj1uDQo+IHN1Y2NlZWRzLg0KPiANCj4gWyAgICAwLjgzMDI4MF0g
ZGVidWdfdm1fcGd0YWJsZTogW2RlYnVnX3ZtX3BndGFibGUgICAgICAgICBdOg0KPiBWYWxp
ZGF0aW5nIGFyY2hpdGVjdHVyZSBwYWdlIHRhYmxlIGhlbHBlcnMNCj4gWyAgICAwLjgzMTkw
Nl0gLS0tLS0tLS0tLS0tWyBjdXQgaGVyZSBdLS0tLS0tLS0tLS0tDQo+IFsgICAgMC44MzI3
MTFdIFdBUk5JTkc6IENQVTogMCBQSUQ6IDEgYXQgbW0vZGVidWdfdm1fcGd0YWJsZS5jOjQ2
MQ0KPiBkZWJ1Z192bV9wZ3RhYmxlKzB4YjlhLzB4ZTE2DQo+IFsgICAgMC44MzM5OThdIE1v
ZHVsZXMgbGlua2VkIGluOg0KPiBbICAgIDAuODM0NDUwXSBDUFU6IDAgUElEOiAxIENvbW06
IHN3YXBwZXIvMCBOb3QgdGFpbnRlZCA2LjIuMC1yYzcrDQo+ICMyMzY2DQo+IFsgICAgMC44
MzU0NjJdIFJJUDogMDAxMDpkZWJ1Z192bV9wZ3RhYmxlKzB4YjlhLzB4ZTE2DQo+IFsgICAg
MC44MzYyMTddIENvZGU6IGUyIDNhIDczIDRhIDQ4IGM3IDAwIDAwIDAwIDAwIDAwIDQ4IDhi
IGI0IDI0IGEwIDAwDQo+IDAwIDAwIDQ4IDhiIDU0IDI0IDYwIDQ4IDhiIDdjIDI0IDIwIDQ4
IGM0DQo+IFsgICAgMC44MzkwNjhdIFJTUDogMDAwMDpmZmZmYzkwMDAwMDEzZGUwIEVGTEFH
UzogMDAwMTAyNDYNCj4gWyAgICAwLjgzOTczNV0gUkFYOiAwMDAwMDAwMDAwMDAwMDAwIFJC
WDogZmZmZjg4ODEwMDA0ODg2OCBSQ1g6DQo+IGJmZmZmZmZmZmZmZmZmZjANCj4gWyAgICAw
Ljg0MDY0Nl0gUkRYOiAwMDAwMDAwMDAwMDAwMDAwIFJTSTogMDAwMDAwMDA0MDAwMDAwMCBS
REk6DQo+IDAwMDAwMDAwMDAwMDAwMDANCj4gWyAgICAwLjg0MTY2MV0gUkJQOiBmZmZmODg4
MTAwMDRkMTQwIFIwODogMDAwMDAwMDAwMDAwMDAwMCBSMDk6DQo+IGZmZmY4ODgxMDAyODA4
ODANCj4gWyAgICAwLjg0MjYyNV0gUjEwOiAwMDAwMDAwMDAwMDAwMDAxIFIxMTogMDAwMDAw
MDAwMDAwMDAwMSBSMTI6DQo+IGZmZmY4ODgxMDM4MTAyOTgNCj4gWyAgICAwLjg0MzU3NF0g
UjEzOiBmZmZmODg4MTAwMDQ4NzgwIFIxNDogZmZmZmZmZmY4MjgyZTA5OSBSMTU6DQo+IDAw
MDAwMDAwMDAwMDAwMDANCj4gWyAgICAwLjg0NDUyNF0gRlM6ICAwMDAwMDAwMDAwMDAwMDAw
KDAwMDApIEdTOmZmZmY4ODgxM2JjMDAwMDAoMDAwMCkNCj4ga25sR1M6MDAwMDAwMDAwMDAw
MDAwMA0KPiBbICAgIDAuODQ1NzA2XSBDUzogIDAwMTAgRFM6IDAwMDAgRVM6IDAwMDAgQ1Iw
OiAwMDAwMDAwMDgwMDUwMDMzDQo+IFsgICAgMC44NDY0OTldIENSMjogZmZmZjg4ODEzZmZm
ZjAwMCBDUjM6IDAwMDAwMDAwMDIyMmQwMDEgQ1I0Og0KPiAwMDAwMDAwMDAwMzcwZWYwDQo+
IFsgICAgMC44NDc0NjRdIERSMDogMDAwMDAwMDAwMDAwMDAwMCBEUjE6IDAwMDAwMDAwMDAw
MDAwMDAgRFIyOg0KPiAwMDAwMDAwMDAwMDAwMDAwDQo+IFsgICAgMC44NDg0MzJdIERSMzog
MDAwMDAwMDAwMDAwMDAwMCBEUjY6IDAwMDAwMDAwZmZmZTBmZjAgRFI3Og0KPiAwMDAwMDAw
MDAwMDAwNDAwDQo+IFsgICAgMC44NDkzNzFdIENhbGwgVHJhY2U6DQo+IFsgICAgMC44NDk2
OTldICA8VEFTSz4NCj4gWyAgICAwLjg0OTk5N10gID8gZGVzdHJveV9hcmdzKzB4MTMxLzB4
MTMxDQo+IFsgICAgMC44NTA0ODddICBkb19vbmVfaW5pdGNhbGwrMHg2MS8weDI1MA0KPiBb
ICAgIDAuODUwOTgzXSAgPyByZGluaXRfc2V0dXArMHgyYy8weDJjDQo+IFsgICAgMC44NTE0
NTFdICBrZXJuZWxfaW5pdF9mcmVlYWJsZSsweDE4ZS8weDFkOA0KPiBbICAgIDAuODUyMDMz
XSAgPyByZXN0X2luaXQrMHgxMzAvMHgxMzANCj4gWyAgICAwLjg1MjUzM10gIGtlcm5lbF9p
bml0KzB4MTYvMHgxMjANCj4gWyAgICAwLjg1MzAzNV0gIHJldF9mcm9tX2ZvcmsrMHgxZi8w
eDMwDQo+IFsgICAgMC44NTM1MDddICA8L1RBU0s+DQo+IFsgICAgMC44NTM4MDNdIC0tLVsg
ZW5kIHRyYWNlIDAwMDAwMDAwMDAwMDAwMDAgXS0tLQ0KPiBbICAgIDAuODU0NDIxXSAtLS0t
LS0tLS0tLS1bIGN1dCBoZXJlIF0tLS0tLS0tLS0tLS0NCj4gWyAgICAwLjg1NTAyN10gV0FS
TklORzogQ1BVOiAwIFBJRDogMSBhdCBtbS9kZWJ1Z192bV9wZ3RhYmxlLmM6NDYyDQo+IGRl
YnVnX3ZtX3BndGFibGUrMHhiYWEvMHhlMTYNCj4gWyAgICAwLjg1NjExNV0gTW9kdWxlcyBs
aW5rZWQgaW46DQo+IFsgICAgMC44NTY1MTddIENQVTogMCBQSUQ6IDEgQ29tbTogc3dhcHBl
ci8wIFRhaW50ZWQ6DQo+IEcgICAgICAgIFcgICAgICAgICAgNi4yLjAtcmM3KyAjMjM2Ng0K
PiBbICAgIDAuODU3NTYyXSBSSVA6IDAwMTA6ZGVidWdfdm1fcGd0YWJsZSsweGJhYS8weGUx
Ng0KPiBbICAgIDAuODU4MTg2XSBDb2RlOiAwMCAwMCAwMCA0OCA4YiA1NCAyNCA2MCA0OCA4
YiA3YyAyNCAyMCA0OCBjMSBlNiAwYw0KPiBlOCA3OSAxOCA3ZiBmZSA4NSBjMCA3NSAwMiAw
ZiAwYiA0OCA4YiA3Yg0KPiBbICAgIDAuODYwNzc4XSBSU1A6IDAwMDA6ZmZmZmM5MDAwMDAx
M2RlMCBFRkxBR1M6IDAwMDEwMjQ2DQo+IFsgICAgMC44NjE1MTldIFJBWDogMDAwMDAwMDAw
MDAwMDAwMCBSQlg6IGZmZmY4ODgxMDAwNDg4NjggUkNYOg0KPiBiZmZmZmZmZmZmZmZmZmYw
DQo+IFsgICAgMC44NjI1MzBdIFJEWDogMDAwMDAwMDAwMDAwMDAwMCBSU0k6IDAwMDAwMDAw
NDAwMDAwMDAgUkRJOg0KPiBmZmZmODg4MTAzODBlN2Y4DQo+IFsgICAgMC44NjM1MjJdIFJC
UDogZmZmZjg4ODEwMDA0ZDE0MCBSMDg6IDAwMDAwMDAwMDAwMDAwMDAgUjA5Og0KPiBmZmZm
ODg4MTAwMjgwODgwDQo+IFsgICAgMC44NjQ0NDldIFIxMDogMDAwMDAwMDAwMDAwMDAwMSBS
MTE6IDAwMDAwMDAwMDAwMDAwMDEgUjEyOg0KPiBmZmZmODg4MTAzODEwMjk4DQo+IFsgICAg
MC44NjU0NTRdIFIxMzogZmZmZjg4ODEwMDA0ODc4MCBSMTQ6IGZmZmZmZmZmODI4MmUwOTkg
UjE1Og0KPiAwMDAwMDAwMDAwMDAwMDAwDQo+IFsgICAgMC44NjY0MDFdIEZTOiAgMDAwMDAw
MDAwMDAwMDAwMCgwMDAwKSBHUzpmZmZmODg4MTNiYzAwMDAwKDAwMDApDQo+IGtubEdTOjAw
MDAwMDAwMDAwMDAwMDANCj4gWyAgICAwLjg2NzQzOF0gQ1M6ICAwMDEwIERTOiAwMDAwIEVT
OiAwMDAwIENSMDogMDAwMDAwMDA4MDA1MDAzMw0KPiBbICAgIDAuODY4MTgxXSBDUjI6IGZm
ZmY4ODgxM2ZmZmYwMDAgQ1IzOiAwMDAwMDAwMDAyMjJkMDAxIENSNDoNCj4gMDAwMDAwMDAw
MDM3MGVmMA0KPiBbICAgIDAuODY5MDk3XSBEUjA6IDAwMDAwMDAwMDAwMDAwMDAgRFIxOiAw
MDAwMDAwMDAwMDAwMDAwIERSMjoNCj4gMDAwMDAwMDAwMDAwMDAwMA0KPiBbICAgIDAuODcw
MDI2XSBEUjM6IDAwMDAwMDAwMDAwMDAwMDAgRFI2OiAwMDAwMDAwMGZmZmUwZmYwIERSNzoN
Cj4gMDAwMDAwMDAwMDAwMDQwMA0KPiBbICAgIDAuODcwOTQzXSBDYWxsIFRyYWNlOg0KPiBb
ICAgIDAuODcxMjU5XSAgPFRBU0s+DQo+IFsgICAgMC44NzE1MzddICA/IGRlc3Ryb3lfYXJn
cysweDEzMS8weDEzMQ0KPiBbICAgIDAuODcyMDMwXSAgZG9fb25lX2luaXRjYWxsKzB4NjEv
MHgyNTANCj4gWyAgICAwLjg3MjUyMV0gID8gcmRpbml0X3NldHVwKzB4MmMvMHgyYw0KPiBb
ICAgIDAuODczMDA1XSAga2VybmVsX2luaXRfZnJlZWFibGUrMHgxOGUvMHgxZDgNCj4gWyAg
ICAwLjg3MzYwN10gID8gcmVzdF9pbml0KzB4MTMwLzB4MTMwDQo+IFsgICAgMC44NzQxMTZd
ICBrZXJuZWxfaW5pdCsweDE2LzB4MTIwDQo+IFsgICAgMC44NzQ2MThdICByZXRfZnJvbV9m
b3JrKzB4MWYvMHgzMA0KPiBbICAgIDAuODc1MTIzXSAgPC9UQVNLPg0KPiBbICAgIDAuODc1
NDExXSAtLS1bIGVuZCB0cmFjZSAwMDAwMDAwMDAwMDAwMDAwIF0tLS0NCg0KVGhhbmtzIGZv
ciB0aGUgcmVwb3J0Lg0KDQpJJ2xsIGhhdmUgYSBsb29rLiBQcm9iYWJseSBJJ2xsIG5lZWQg
dG8gcmUtYWRkIHRoZSBjaGVjayBmb3IgV0IgaW4gcGF0Y2ggNy4NCg0KDQpKdWVyZ2VuDQo=

--------------WIiv0hoECcgZufueRJws0bAS
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------WIiv0hoECcgZufueRJws0bAS--

--------------ACsfdmS5eSJC8hchh3zvew2M--

--------------f1vstKnhITA2oOGQSyz67zP0
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmPp1LkFAwAAAAAACgkQsN6d1ii/Ey8p
vgf+MX3FtPvUqJ51vtu71gdi2LkG2zaQaYoChzNf5zu+U0J5YzssQ7LR6Okpi/Zc+iX5xTror/gh
XeVCOkkM9SZw6JLjeYl2h1R9NRrBJiNKp8QBb+JWp5SAQd692DaLTc5NoKOM61QvFIdaf5euT2ht
/JAizM62UbOHfaIxRsRaUSllQTvb9WnRu+45FlSWK5hovc4uydZFkMMDhCvUQOTAKA2W9NmpZWKd
YiUfoqItqz2Rd5ongLB5HbSkK2fOQIEQQ7Zjc7UbjNZwozZmyRaPW+Kf+dQ7CAH2RyQZMWZJdo62
QQ2FdAqolZZL5kzHpXG6sc2gGandAabKKgnCh/61iQ==
=+cRs
-----END PGP SIGNATURE-----

--------------f1vstKnhITA2oOGQSyz67zP0--
