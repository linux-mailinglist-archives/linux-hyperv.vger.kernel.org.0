Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E37E1719D01
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 Jun 2023 15:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233446AbjFANLI (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 1 Jun 2023 09:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233443AbjFANLH (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 1 Jun 2023 09:11:07 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 286BB13E;
        Thu,  1 Jun 2023 06:11:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 71D6C2191E;
        Thu,  1 Jun 2023 13:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1685625060; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Vr62W274cXGwQ8+W+lAGpQ6yZZzLPVRhoHaedh9+CgI=;
        b=aOUlSr6MvAAKaXEBDIy7IxVpKxkl5FFa03HagOrYGuyQG/1+5dqQiPMwpZvSLBYxELQSCv
        bjtKFHk42xQAI2uXbXeorKwOG5uf3ujWXbvpQmq3YfH4lJ1YajjYFwi0fs9X2x66K/ywZv
        Mh8hQ6C4D3szEuDFJz6mP+UB7UNB6Pk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DEFFC13441;
        Thu,  1 Jun 2023 13:10:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EIoMNOOYeGSoIwAAMHmgww
        (envelope-from <jgross@suse.com>); Thu, 01 Jun 2023 13:10:59 +0000
Message-ID: <a68b22c5-c1c2-2cc2-0d9d-69cee92fc779@suse.com>
Date:   Thu, 1 Jun 2023 15:10:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v6 00/16] x86/mtrr: fix handling with PAT but without MTRR
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
In-Reply-To: <20230531174857.GDZHeIib57h5lT5Vh1@fat_crate.local>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------Me2DONSdYXHZk4ld00WCHwyU"
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------Me2DONSdYXHZk4ld00WCHwyU
Content-Type: multipart/mixed; boundary="------------7rrFzZroE9mvl6SWtGrJbP0b";
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
Message-ID: <a68b22c5-c1c2-2cc2-0d9d-69cee92fc779@suse.com>
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

--------------7rrFzZroE9mvl6SWtGrJbP0b
Content-Type: multipart/mixed; boundary="------------589veGrPJrwdjA0vG5RF5qDL"

--------------589veGrPJrwdjA0vG5RF5qDL
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMzEuMDUuMjMgMTk6NDgsIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gT24gV2VkLCBN
YXkgMzEsIDIwMjMgYXQgMDQ6MjA6MDhQTSArMDIwMCwgSnVlcmdlbiBHcm9zcyB3cm90ZToN
Cj4+IE9uZSBvdGhlciBub3RlOiB3aHkgZG9lcyBtdHJyX2NsZWFudXAoKSB0aGluayB0aGF0
IHVzaW5nIDggaW5zdGVhZCBvZiA2DQo+PiB2YXJpYWJsZSBNVFJScyB3b3VsZCBiZSBhbiAi
b3B0aW1hbCBzZXR0aW5nIj8NCj4gDQo+IE1heWJlIHRoZSBtb3JlIGV4dGVuc2l2ZSBkZWJ1
ZyBvdXRwdXQgYmVsb3cgd291bGQgaGVscCBhbnN3ZXIgdGhhdC4uLg0KPiANCj4+IElNTyBp
dCBzaG91bGQgcmVwbGFjZSB0aGUgb3JpZ2luYWwgc2V0dXAgb25seSBpbiBjYXNlIGl0IGlz
IHVzaW5nIF9sZXNzXw0KPj4gTVRSUnMgdGhhbiBiZWZvcmUuDQo+IA0KPiBSaWdodC4NCg0K
VGhlIGF0dGFjaGVkIHBhdGNoIHdpbGwgZG8gdGhhdC4NCg0KDQpKdWVyZ2VuDQoNCg==
--------------589veGrPJrwdjA0vG5RF5qDL
Content-Type: text/x-patch; charset=UTF-8;
 name="v7-0001-x86-mtrr-Let-mtrr_cleanup-not-increase-number-of-.patch"
Content-Disposition: attachment;
 filename*0="v7-0001-x86-mtrr-Let-mtrr_cleanup-not-increase-number-of-.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSA3OTg5ZWY5ODIyMTE1YTcwOGZjMmJhM2Y3NzQwODg4YTM1MGNiNDBmIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKdWVyZ2VuIEdyb3NzIDxqZ3Jvc3NAc3VzZS5jb20+
CkRhdGU6IFRodSwgMSBKdW4gMjAyMyAxNDo0MDo1OCArMDIwMApTdWJqZWN0OiBbUEFUQ0gg
djddIHg4Ni9tdHJyOiBMZXQgbXRycl9jbGVhbnVwKCkgbm90IGluY3JlYXNlIG51bWJlciBv
ZiB1c2VkCiBNVFJScwoKVG9kYXkgbXRycl9jbGVhbnVwKCkgd2lsbCBhbHdheXMgdXNlIHRo
ZSBiZXN0IGZvdW5kIGFsdGVybmF0aXZlIE1UUlIKc2V0dGluZywgZXZlbiBpZiB0aGlzIHNl
dHRpbmcgaXMgdXNpbmcgbW9yZSB2YXJpYWJsZSBNVFJScyB0aGFuIHRoZQpCSU9TIHByb3Zp
ZGVkIHNldHVwLgoKQWRkIGEgY2hlY2sgdGhhdCBvbmx5IHNldHRpbmdzIHdpdGggbGVzcyB2
YXJpYWJsZSBNVFJScyBhcmUgdXNlZC4KClNpZ25lZC1vZmYtYnk6IEp1ZXJnZW4gR3Jvc3Mg
PGpncm9zc0BzdXNlLmNvbT4KLS0tClY3OgotIG5ldyBwYXRjaAotLS0KIGFyY2gveDg2L2tl
cm5lbC9jcHUvbXRyci9jbGVhbnVwLmMgfCAxNiArKysrKysrKysrKysrLS0tCiAxIGZpbGUg
Y2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQg
YS9hcmNoL3g4Ni9rZXJuZWwvY3B1L210cnIvY2xlYW51cC5jIGIvYXJjaC94ODYva2VybmVs
L2NwdS9tdHJyL2NsZWFudXAuYwppbmRleCBhN2NiNWQzMmQwM2QuLmE1ZDMzMTcyMjA5MiAx
MDA2NDQKLS0tIGEvYXJjaC94ODYva2VybmVsL2NwdS9tdHJyL2NsZWFudXAuYworKysgYi9h
cmNoL3g4Ni9rZXJuZWwvY3B1L210cnIvY2xlYW51cC5jCkBAIC01NjcsNyArNTY3LDcgQEAg
c3RhdGljIGludCBfX2luaXQgbXRycl9uZWVkX2NsZWFudXAodm9pZCkKIAkgICAgbnVtX3Zh
cl9yYW5nZXMgLSBudW1bTVRSUl9OVU1fVFlQRVNdKQogCQlyZXR1cm4gMDsKIAotCXJldHVy
biAxOworCXJldHVybiBudW1fdmFyX3JhbmdlcyAtIG51bVtNVFJSX05VTV9UWVBFU107CiB9
CiAKIHN0YXRpYyB1bnNpZ25lZCBsb25nIF9faW5pdGRhdGEgcmFuZ2Vfc3VtczsKQEAgLTY3
Myw2ICs2NzMsNyBAQCBpbnQgX19pbml0IG10cnJfY2xlYW51cCh2b2lkKQogCXU2NCBjaHVu
a19zaXplLCBncmFuX3NpemU7CiAJbXRycl90eXBlIHR5cGU7CiAJaW50IGluZGV4X2dvb2Q7
CisJaW50IG51bV91c2VkOwogCWludCBpOwogCiAJaWYgKCFjcHVfZmVhdHVyZV9lbmFibGVk
KFg4Nl9GRUFUVVJFX01UUlIpIHx8IGVuYWJsZV9tdHJyX2NsZWFudXAgPCAxKQpAQCAtNjkz
LDcgKzY5NCw4IEBAIGludCBfX2luaXQgbXRycl9jbGVhbnVwKHZvaWQpCiAJfQogCiAJLyog
Q2hlY2sgaWYgd2UgbmVlZCBoYW5kbGUgaXQgYW5kIGNhbiBoYW5kbGUgaXQ6ICovCi0JaWYg
KCFtdHJyX25lZWRfY2xlYW51cCgpKQorCW51bV91c2VkID0gbXRycl9uZWVkX2NsZWFudXAo
KTsKKwlpZiAoIW51bV91c2VkKQogCQlyZXR1cm4gMDsKIAogCS8qIFByaW50IG9yaWdpbmFs
IHZhciBNVFJScyBhdCBmaXJzdCwgZm9yIGRlYnVnZ2luZzogKi8KQEAgLTcyOCw2ICs3MzAs
MTAgQEAgaW50IF9faW5pdCBtdHJyX2NsZWFudXAodm9pZCkKIAkJbXRycl9wcmludF9vdXRf
b25lX3Jlc3VsdChpKTsKIAogCQlpZiAoIXJlc3VsdFtpXS5iYWQpIHsKKwkJCWlmIChyZXN1
bHRbaV0ubnVtX3JlZyA+PSBudW1fdXNlZCkgeworCQkJCURwcmludGsoIkJJT1MgcHJvdmlk
ZWQgTVRSUiBzZXR0aW5nIGlzIGJldHRlciB0aGFuIGZvdW5kIG9uZVxuIik7CisJCQkJcmV0
dXJuIDA7CisJCQl9CiAJCQlzZXRfdmFyX210cnJfYWxsKCk7CiAJCQlEcHJpbnRrKCJOZXcg
dmFyaWFibGUgTVRSUnNcbiIpOwogCQkJcHJpbnRfb3V0X210cnJfcmFuZ2Vfc3RhdGUoKTsK
QEAgLTc2Miw4ICs3NjgsMTIgQEAgaW50IF9faW5pdCBtdHJyX2NsZWFudXAodm9pZCkKIAlp
bmRleF9nb29kID0gbXRycl9zZWFyY2hfb3B0aW1hbF9pbmRleCgpOwogCiAJaWYgKGluZGV4
X2dvb2QgIT0gLTEpIHsKLQkJcHJfaW5mbygiRm91bmQgb3B0aW1hbCBzZXR0aW5nIGZvciBt
dHJyIGNsZWFuIHVwXG4iKTsKIAkJaSA9IGluZGV4X2dvb2Q7CisJCWlmIChyZXN1bHRbaV0u
bnVtX3JlZyA+PSBudW1fdXNlZCkgeworCQkJRHByaW50aygiQklPUyBwcm92aWRlZCBNVFJS
IHNldHRpbmcgaXMgYmV0dGVyIHRoYW4gZm91bmQgb25lXG4iKTsKKwkJCXJldHVybiAwOwor
CQl9CisJCXByX2luZm8oIkZvdW5kIG9wdGltYWwgc2V0dGluZyBmb3IgbXRyciBjbGVhbiB1
cFxuIik7CiAJCW10cnJfcHJpbnRfb3V0X29uZV9yZXN1bHQoaSk7CiAKIAkJLyogQ29udmVy
dCByYW5nZXMgdG8gdmFyIHJhbmdlcyBzdGF0ZTogKi8KLS0gCjIuMzUuMwoK
--------------589veGrPJrwdjA0vG5RF5qDL
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
jR/i1DG86lem3iBDXzXsZDn8R38=3D
=3D2wuH
-----END PGP PUBLIC KEY BLOCK-----

--------------589veGrPJrwdjA0vG5RF5qDL--

--------------7rrFzZroE9mvl6SWtGrJbP0b--

--------------Me2DONSdYXHZk4ld00WCHwyU
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmR4mOMFAwAAAAAACgkQsN6d1ii/Ey++
cgf+LkzsFtcV7YcNisTcySgsQZOL5dMBOUhTeLzx9eo3IUoPy9y1vlhTT1KZS5zJYU+hPZE17SS2
e+zpOx/qJ0ocnJjqdWes766KrXUjsrIobPSHMWEoEH3uR6XIh0VZuQpzzFaH7bcNJ4SIJUoXt1Oc
U6jnPx/dAbmdHCptUsS6PMaodx+faq6CvJn8Ql+d3XTDsWQNB0Y7yOTDvBlgzvaTcy2PhaGxiCBj
7ygFQDLTo2CmCr6K88i2NfblmC2wo/oVQlebw6cq5JmiZqziZbjs1+nNw67zsZSF4FGq1/3Fuhe8
PpSdDx0B87h/iNB8BGKser1DHNtctNwA/QA2y6L0uQ==
=JaUs
-----END PGP SIGNATURE-----

--------------Me2DONSdYXHZk4ld00WCHwyU--
