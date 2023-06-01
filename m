Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3CBF719548
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 Jun 2023 10:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbjFAITZ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 1 Jun 2023 04:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbjFAITR (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 1 Jun 2023 04:19:17 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75468189;
        Thu,  1 Jun 2023 01:19:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1E09C2195F;
        Thu,  1 Jun 2023 08:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1685607542; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WkaB/dK8xrG5SL8wE9N8/1S4RV6q2XZjN4rCgCLd8hE=;
        b=SYvQRgTfg1o6Jc+MhsYnXDrEdiIAqCN+28AB4Ih6MC93GZzV46RJ1/9FDqnMvr5sEDh0pE
        Zkeo4kK8K2+IoWbBfgYvRPMaYv8oWiF5ldbk3P56lTSgibnRDSdmw7vHZGVerCtOBjXlaK
        3TNKX198dlMasClONwSG2jS/+AkawHY=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 88747139B7;
        Thu,  1 Jun 2023 08:19:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gd/RH3VUeGTpfgAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 01 Jun 2023 08:19:01 +0000
Message-ID: <fe33476d-0ec1-16f1-5874-8a5ff1650c3f@suse.com>
Date:   Thu, 1 Jun 2023 10:19:01 +0200
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
References: <20230509201437.GFZFqprc6otRejDPUt@fat_crate.local>
 <20230509233641.GGZFrZCTDH7VwUMp5R@fat_crate.local>
 <20230510133024.GBZFuccC1FxIZNKL+8@fat_crate.local>
 <4c47a11c-0565-678d-3467-e01c5ec16600@suse.com>
 <20230511163208.GDZF0YiOfxQhSo4RDm@fat_crate.local>
 <0cd3899b-cf3b-61c1-14ae-60b6b49d14ab@suse.com>
 <20230530152825.GAZHYWGXAp8PHgN/w0@fat_crate.local>
 <888f860d-4307-54eb-01da-11f9adf65559@suse.com>
 <20230531083508.GAZHcGvB68PUAH7f+a@fat_crate.local>
 <efe79c9e-1e31-adb9-8f93-962249bf01bb@suse.com>
 <20230531174857.GDZHeIib57h5lT5Vh1@fat_crate.local>
From:   Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH v6 00/16] x86/mtrr: fix handling with PAT but without MTRR
In-Reply-To: <20230531174857.GDZHeIib57h5lT5Vh1@fat_crate.local>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------TKrpmhFrL3wVlG7bmD5W5KrA"
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------TKrpmhFrL3wVlG7bmD5W5KrA
Content-Type: multipart/mixed; boundary="------------avHWsmjs7KZwzreMH8jZG9gZ";
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
Message-ID: <fe33476d-0ec1-16f1-5874-8a5ff1650c3f@suse.com>
Subject: Re: [PATCH v6 00/16] x86/mtrr: fix handling with PAT but without MTRR
References: <20230509201437.GFZFqprc6otRejDPUt@fat_crate.local>
 <20230509233641.GGZFrZCTDH7VwUMp5R@fat_crate.local>
 <20230510133024.GBZFuccC1FxIZNKL+8@fat_crate.local>
 <4c47a11c-0565-678d-3467-e01c5ec16600@suse.com>
 <20230511163208.GDZF0YiOfxQhSo4RDm@fat_crate.local>
 <0cd3899b-cf3b-61c1-14ae-60b6b49d14ab@suse.com>
 <20230530152825.GAZHYWGXAp8PHgN/w0@fat_crate.local>
 <888f860d-4307-54eb-01da-11f9adf65559@suse.com>
 <20230531083508.GAZHcGvB68PUAH7f+a@fat_crate.local>
 <efe79c9e-1e31-adb9-8f93-962249bf01bb@suse.com>
 <20230531174857.GDZHeIib57h5lT5Vh1@fat_crate.local>
In-Reply-To: <20230531174857.GDZHeIib57h5lT5Vh1@fat_crate.local>

--------------avHWsmjs7KZwzreMH8jZG9gZ
Content-Type: multipart/mixed; boundary="------------rbANpMXHagpw1nH3ypDTwa0R"

--------------rbANpMXHagpw1nH3ypDTwa0R
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMzEuMDUuMjMgMTk6NDgsIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gT24gV2VkLCBN
YXkgMzEsIDIwMjMgYXQgMDQ6MjA6MDhQTSArMDIwMCwgSnVlcmdlbiBHcm9zcyB3cm90ZToN
Cj4+IE9uZSBvdGhlciBub3RlOiB3aHkgZG9lcyBtdHJyX2NsZWFudXAoKSB0aGluayB0aGF0
IHVzaW5nIDggaW5zdGVhZCBvZiA2DQo+PiB2YXJpYWJsZSBNVFJScyB3b3VsZCBiZSBhbiAi
b3B0aW1hbCBzZXR0aW5nIj8NCj4gDQo+IE1heWJlIHRoZSBtb3JlIGV4dGVuc2l2ZSBkZWJ1
ZyBvdXRwdXQgYmVsb3cgd291bGQgaGVscCBhbnN3ZXIgdGhhdC4uLg0KDQpQYXRjaCAyIHdh
bnRzIHRoaXMgZGlmZiBvbiB0b3A6DQoNCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwv
Y3B1L210cnIvZ2VuZXJpYy5jIGIvYXJjaC94ODYva2VybmVsL2NwdS9tdHJyL2dlbmVyaWMu
Yw0KaW5kZXggNTliNDhiZDgzODBjLi5jZTI1NGNhODljNjIgMTAwNjQ0DQotLS0gYS9hcmNo
L3g4Ni9rZXJuZWwvY3B1L210cnIvZ2VuZXJpYy5jDQorKysgYi9hcmNoL3g4Ni9rZXJuZWwv
Y3B1L210cnIvZ2VuZXJpYy5jDQpAQCAtNjU1LDcgKzY1NSw3IEBAIHN0YXRpYyBib29sIHNl
dF9tdHJyX3Zhcl9yYW5nZXModW5zaWduZWQgaW50IGluZGV4LCBzdHJ1Y3QgDQptdHJyX3Zh
cl9yYW5nZSAqdnIpDQogICAgICAgICBib29sIGNoYW5nZWQgPSBmYWxzZTsNCg0KICAgICAg
ICAgcmRtc3IoTVRSUnBoeXNCYXNlX01TUihpbmRleCksIGxvLCBoaSk7DQotICAgICAgIGlm
ICgodnItPmJhc2VfbG8gJiBNVFJSX1BIWVNCQVNFX1JTVkQpICE9IChsbyAmIE1UUlJfUEhZ
U0JBU0VfUlNWRCkNCisgICAgICAgaWYgKCh2ci0+YmFzZV9sbyAmIH5NVFJSX1BIWVNCQVNF
X1JTVkQpICE9IChsbyAmIH5NVFJSX1BIWVNCQVNFX1JTVkQpDQogICAgICAgICAgICAgfHwg
KHZyLT5iYXNlX2hpICYgfnBoeXNfaGlfcnN2ZCkgIT0gKGhpICYgfnBoeXNfaGlfcnN2ZCkp
IHsNCg0KICAgICAgICAgICAgICAgICBtdHJyX3dybXNyKE1UUlJwaHlzQmFzZV9NU1IoaW5k
ZXgpLCB2ci0+YmFzZV9sbywgdnItPmJhc2VfaGkpOw0KQEAgLTY2NCw3ICs2NjQsNyBAQCBz
dGF0aWMgYm9vbCBzZXRfbXRycl92YXJfcmFuZ2VzKHVuc2lnbmVkIGludCBpbmRleCwgc3Ry
dWN0IA0KbXRycl92YXJfcmFuZ2UgKnZyKQ0KDQogICAgICAgICByZG1zcihNVFJScGh5c01h
c2tfTVNSKGluZGV4KSwgbG8sIGhpKTsNCg0KLSAgICAgICBpZiAoKHZyLT5tYXNrX2xvICYg
TVRSUl9QSFlTTUFTS19SU1ZEKSAhPSAobG8gJiBNVFJSX1BIWVNNQVNLX1JTVkQpDQorICAg
ICAgIGlmICgodnItPm1hc2tfbG8gJiB+TVRSUl9QSFlTTUFTS19SU1ZEKSAhPSAobG8gJiB+
TVRSUl9QSFlTTUFTS19SU1ZEKQ0KICAgICAgICAgICAgIHx8ICh2ci0+bWFza19oaSAmIH5w
aHlzX2hpX3JzdmQpICE9IChoaSAmIH5waHlzX2hpX3JzdmQpKSB7DQogICAgICAgICAgICAg
ICAgIG10cnJfd3Jtc3IoTVRSUnBoeXNNYXNrX01TUihpbmRleCksIHZyLT5tYXNrX2xvLCB2
ci0+bWFza19oaSk7DQogICAgICAgICAgICAgICAgIGNoYW5nZWQgPSB0cnVlOw0KDQoNCg0K
SnVlcmdlbg0K
--------------rbANpMXHagpw1nH3ypDTwa0R
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------rbANpMXHagpw1nH3ypDTwa0R--

--------------avHWsmjs7KZwzreMH8jZG9gZ--

--------------TKrpmhFrL3wVlG7bmD5W5KrA
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmR4VHUFAwAAAAAACgkQsN6d1ii/Ey+J
twf/eQjv8nuDSbYV2TCPrcrs+yZ/Jh9nuEt69gAXyJLlg62X3l+NThYbS8jT3yBmlIesvryNqixd
W+Q29UtGgdqXjI/SpqWqCaMhNfRWrUFdXPfLZB4tsP8gi/nw/G6c4qvehl2WKOCI0F2LGxHtx+LV
Ay+k2smkQaT1w6s4GU3sIcmi/+2Dd+ekm0ugo2aj2lQ2X6JpauyJ5hDqLm+KigQqbiPcaZ0Q7fzq
937YGeNF6h1vkOVSDwWk2yxHlzRZ6b54WMY83z810obsLQnQsITDIMV8DOjDLszsoN3k3nxIQp4O
odbvQrE3TePQ8ESO0vxg0K4qwk7LOoo9m0P8YykloQ==
=fnFv
-----END PGP SIGNATURE-----

--------------TKrpmhFrL3wVlG7bmD5W5KrA--
